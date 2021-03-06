node default { include nagios_nrpe }

node 'thor.elisa' { include lamp }

node 'win7box.local' { include nscp }

node 'hngu.elisa' { 
  class { 'postfix':
    version   => 'latest',
    myorigin  => 'elisa.fi',
    relayhost => 'smtp.kolumbus.fi',
  }
  class { 'nagios3':
    version => 'latest',
  }
  linuxhost { 'linux1':
    name    => 'Ubuntu Linux',
    address => '192.168.100.111',
  }
  linuxhost { 'linux2':
    name    => 'Xubuntu Linux',
    address => 'thor.local'
  }
  winhost { 'win1':
    name    => 'windows',
    address => '192.168.100.25',
  }
  myhost { 'host1':
    name    => 'host1',
    group   => 'group1',
    address => 'host1.local',
  }
  mygroup { 'group1': }

  myservice { 'checkfile':
    host => 'win1',
    cmd  => 'check_nrpe!check_files!/path:"c:\\temp" /namefilter:"test\.txt" /expectmatch:1 /age:30n /selage:newer /warning:1: /critical:1:',
    desc => 'File backup test',
  }
}
