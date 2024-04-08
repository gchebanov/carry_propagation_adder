import argparse


# old python workaround
def removesuffix(s, suff):
    assert s.endswith(suff)
    return s[:-len(suff)]


def fix_parameter(file_path, line_number, initial, to):
    with open(file_path, 'rt') as file:
        lines = file.readlines()
    lines[line_number] = removesuffix(lines[line_number], initial + '\n') + to + '\n'
    with open(file_path, 'wt') as file:
        file.writelines(lines)


name_dict = {
    'hc': 'han_carlson',
    'bk': 'brent_kung',
    'ks': 'kogge_stone',
    'lf': 'lander_fischer',
    'internal': 'internal',
}


def build(name, bits):
    assert name in name_dict
    import siliconcompiler
    chip = siliconcompiler.Chip(f'rtl_{name}{bits}')
    file_path = f'rtl_{name}.v'
    fix_parameter(file_path, 1, '64', f'{bits}')
    try:
        chip.input(file_path)
        chip.set('option', 'entrypoint', f'rtl_{name}')
        if full_name := name_dict.get(name, None):
            chip.input(f'{full_name}.v')
        chip.clock(pin='clk', period=25)
        chip.load_target("asap7_demo")
        chip.set('option', 'relax', True)
        chip.set('option', 'quiet', True)
        chip.run()
        chip.summary()
    finally:
        fix_parameter(file_path, 1, f'{bits}', '64')


def main():
    p = argparse.ArgumentParser()
    p.add_argument('name', default='internal', choices=name_dict.keys())
    p.add_argument('bits', default=64)
    args = p.parse_args()
    build(args.name, args.bits)


if __name__ == '__main__':
    main()
