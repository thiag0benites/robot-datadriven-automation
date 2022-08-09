import os

def run_command_lines(cmd):
    directories = os.system(cmd)
    print(directories)