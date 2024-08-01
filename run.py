import qsharp
import argparse
import os
import sys

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
                    prog='QSharpProjects',
                    description='Run QSharp Files')
    
    parser.add_argument('path', type=str, help="path to your project")
    parser.add_argument('namespace', type=str, help="namespace of your project")
    parser.add_argument('op', type=str, help="the operation you want to execute")

    args = parser.parse_args()

    if(not os.path.exists(args.path)):
        print("invalid Path!")
        sys.exit(1)

    qsharp.init(project_root=args.path)

    qsharp.eval(f'{args.namespace}.{args.op}()')