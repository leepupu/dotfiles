import subprocess
import re

class AutoAttach (gdb.Command):

  def __init__ (self):
    super (AutoAttach, self).__init__ ("at", gdb.COMMAND_USER)

  def invoke (self, arg, from_tty):
    try:
      gdb.execute('info proc', True, True)
      gdb.execute('kill', True, True)
    except gdb.error:
      pass

    if arg:
      fn = arg
    else:
      fn = re.findall('Symbols from "(.*)"', gdb.execute('info files', True, True))[0]

    ps = list(map(int, subprocess.check_output(['/bin/pidof',fn]).split()))[0]
    gdb.execute('attach %d' % ps)
    gdb.execute('c')


class BPPIE(gdb.Command):
    def __init__(self):
        gdb.Command.__init__(self, "bpie", gdb.COMMAND_BREAKPOINTS, -1, True)

    def invoke( self, arg, from_tty):
        if not arg:
            print ('no adr')
            return
        try:
            data = gdb.execute('info proc', True, True)
            lines = data.split('\n')
            pid = lines[0].split(' ')[-1]
            cmd = lines[3].split('=')[-1].strip().replace("'", "")
            path = '/proc/'+pid+'/maps'
            mmap = subprocess.check_output(['cat',path]).decode('UTF-8')
            lines = mmap.split('\n')
            first = next(line for line in lines if cmd in line)
            base = int(first.split('-')[0], 16)
            print("invoked", hex(base))
            gdb.execute('b *' + hex(int(arg, 16)+base))
        except gdb.error:
            print("failed")


AutoAttach()
BPPIE()

