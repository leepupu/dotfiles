source ~/peda/peda.py

set disassembly-flavor intel

define at
  shell echo attach $(pidof -s $arg0) >/tmp/foo.gdb
  source /tmp/foo.gdb
end
