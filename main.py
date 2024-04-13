import argparse
from collections.abc import Iterable, ByteString


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
    'hc_1k': 'han_carlson',
    'hc_2k': 'han_carlson',
    'bk': 'brent_kung',
    'ks': 'kogge_stone',
    'lf': 'lander_fischer',
    'internal': 'internal',
    'rca': 'rca',
    'cs': ['conditional_sum', 'internal', 'conditional_sum_combine'],
    'csp': ['conditional_sum_p', 'internal'],
    'css': ['carry_select', 'internal'],
    'cnt': None,
    'cnt_p': ['rtl_cnt'],
    'cnt_l': None,
    'cnt_lp': None,
}


def build(name, bits, use_fpga, remote):
    assert name in name_dict
    import siliconcompiler
    chip = siliconcompiler.Chip(f'rtl_{name}{bits}')
    file_path = f'rtl_{name}.v'
    fix_parameter(file_path, 1, '64', f'{bits}')
    try:
        chip.input(file_path)
        chip.set('option', 'entrypoint', f'rtl_{name}')
        if full_name := name_dict.get(name, None):
            if isinstance(full_name, str):
                chip.input(f'{full_name}.v')
            elif isinstance(full_name, Iterable):
                for e in full_name:
                    chip.input(f'{e}.v')
            else:
                raise ValueError(str(full_name))
        chip.clock(pin='clk', period=25)

        if use_fpga:
            chip.set('fpga', 'partname', 'ice40up5k-sg48')
            chip.load_target("fpgaflow_demo")
        else:
            chip.load_target("asap7_demo")

        chip.set('option', 'relax', True)
        chip.set('option', 'quiet', True)
        if remote:
            chip.set('option', 'remote', remote)
        chip.run()
        chip.summary()
    finally:
        fix_parameter(file_path, 1, f'{bits}', '64')


def main():
    p = argparse.ArgumentParser()
    p.add_argument('name', default='internal', choices=name_dict.keys())
    p.add_argument('bits', default=64)
    p.add_argument('-f', action="store_true", help="Use fpgaflow with ice40up5k-sg48")
    p.add_argument('-r', action="store_true", help="remote build")
    args = p.parse_args()
    build(args.name, args.bits, args.f, args.r)


if __name__ == '__main__':
    main()
