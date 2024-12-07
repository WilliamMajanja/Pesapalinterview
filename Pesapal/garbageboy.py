import sys

def write_command(file, command_byte, *args):
    file.write(bytes([command_byte]))
    file.write(bytes([len(args)]))
    for arg in args:
        file.write(bytes([arg]))

def main():
    with open("output.bin", "wb") as f:
        # Your commands here
        write_command(f, 0x01, 80, 25, 0x01)  # Screen setup
        # ... other commands ...

if __name__ == "__main__":
    main()
