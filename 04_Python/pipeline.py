from pathlib import Path
import argparse
from olist import experience
if __name__=='__main__':
    parser=argparse.ArgumentParser(description='Olist Customer Experience')
    parser.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1])
    args=parser.parse_args()
    c=experience(args.root)
    print('\n'.join(c.findings))
