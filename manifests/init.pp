#
class pe_slack_bot (
  String $slack_api_key,
  String $host        = $settings::ca_server,
  String $hostprivkey = $settings::hostprivkey,
  String $hostpubkey  = $settings::hostcert,
  String $cakey       = $settings::localcacert,
  String $mode        = 'install', # uninstall
) {

  $ensure_latest = $mode ? {
    'uninstall' => 'absent',
    default     => 'latest',
  }

  $ensure_present = $mode ? {
    'uninstall' => 'absent',
    default     => 'present',
  }

  $ensure_running = $mode ? {
    'uninstall' => 'stopped',
    default     => 'running',
  }

  $ensure_directory = $mode ? {
    'uninstall' => 'absent',
    default     => 'directory',
  }

  $ensure_version_activesupport = $mode ? {
    'uninstall' => 'absent',
    default     => '4.2.6',
  }

  $gems = ['puma','sinatra','dotenv','puppetdb-ruby','slack-ruby-bot','foreman','rspec','json_pure','rack-test']

  package { 'gcc-c++':
    ensure   => $ensure_latest,
  }

  package { $gems:
    ensure   => $ensure_latest,
    provider => 'puppet_gem',
    before   => Vcsrepo['/opt/pe-slack-bot'],
    require  => Package['gcc-c++'],
  }

  package { 'activesupport':
    ensure   => $ensure_version_activesupport,
    provider => 'puppet_gem',
    before   => Vcsrepo['/opt/pe-slack-bot'],
    require  => Package['gcc-c++'],
  }

  file { "${settings::confdir}/peslackbot.yaml":
    ensure  => $ensure_present,
    owner   => 'pe-puppet',
    group   => 'pe-puppet',
    mode    => '0644',
    content => template('pe_slack_bot/peslackbot.yaml.erb'),
  }

  vcsrepo { '/opt/pe-slack-bot':
    ensure   => $ensure_latest,
    provider => git,
    source   => 'git://github.com/ncorrare/pe-slack-bot.git',
    revision => 'master',
    require  => File["${settings::confdir}/peslackbot.yaml"],
  }
  file { '/opt/pe-slack-bot':
    ensure  => $ensure_directory,
    owner   => 'pe-puppet',
    require => Vcsrepo['/opt/pe-slack-bot'],
    before  => Service['peslackbot'],
  }

  file { '/usr/lib/systemd/system/peslackbot.service':
    ensure  => $ensure_present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('pe_slack_bot/peslackbot.service.erb'),
    notify  => Exec['/bin/systemctl daemon-reload'],
    require => Vcsrepo['/opt/pe-slack-bot'],
  }

  exec { '/bin/systemctl daemon-reload':
    refreshonly => true,
  }

  service { 'peslackbot':
    ensure  => $ensure_running,
    enable  => true,
    require => File['/usr/lib/systemd/system/peslackbot.service'],
  }

}
