class pe_slack_bot (
  $slack_api_key,
  $host        = $settings::ca_server,
  $hostprivkey = $settings::hostpubkey,
  $hostpubkey  = $settings::hostcert,
  $cakey       = $settings::localcacert,
) {
  $gemdeps = ['activesupport','puma','sinatra','dotenv','puppetdb-ruby','slack-ruby-bot','bundler','foreman','rspec','json_pure']
  package { $gemdeps:
    ensure   => latest,
    provider => 'puppet_gem',
    before   => Vcsrepo['/opt/pe-slack-bot'],
  }

  file { "${settings::confdir}/peslackbot.yaml":
    ensure  => present,
    owner   => 'pe-puppet',
    group   => 'pe-puppet',
    mode    => '0644',
    content => template('pe_slack_bot/peslackbot.yaml.erb'),
  }

  vcsrepo { '/opt/pe-slack-bot':
    ensure   => latest,
    provider => git,
    source   => 'git://github.com/ncorrare/pe-slack-bot.git',
    revision => 'master',
    require  => File["${settings::confdir}/peslackbot.yaml"],
  }

  file { '/usr/lib/systemd/system/peslackbot.service':
    ensure  => present,
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
    ensure  => running,
    enable => true,
    require => File['/usr/lib/systemd/system/peslackbot.service'],
  }

}
