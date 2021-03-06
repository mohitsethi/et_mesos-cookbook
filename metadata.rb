name             'et_mesos'
maintainer       'EverTrue'
maintainer_email 'devops@evertrue.com'
license          'MIT'
description      'Installs/Configures mesos'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '6.0.1'
issues_url       'https://github.com/evertrue/et_mesos-cookbook/issues' if respond_to?(:issues_url)
source_url       'https://github.com/evertrue/et_mesos-cookbook/' if respond_to?(:source_url)

supports         'ubuntu', '>= 14.04'
supports         'centos', '>= 6.5'

recipe           'et_mesos::default', 'install mesos.'
recipe           'et_mesos::package', 'install mesos from mesosphere package.'
recipe           'et_mesos::master',  'configure the machine as master.'
recipe           'et_mesos::slave',   'configure the machine as slave.'

depends          'java',            '~> 1.35'
depends          'ulimit',          '>= 0.3'
depends          'yum',             '>= 3.7'

suggests         'docker'
suggests         'zookeeper'

attribute       'et_mesos/version',
  recipes:      ['et_mesos::package'],
  display_name: 'Version to be installed.',
  description:  "branch name or tag name at http://github.com/apache/mesos, or mesos's version name",
  default:      '0.23.0'

attribute       'et_mesos/package/with_zookeeper',
  recipes:      ['et_mesos::package'],
  display_name: 'switch for installing zookeeper packages',
  description:  "if true, zookeeper packages will be installed with mesosphere's mesos package",
  default:      'false'

attribute       'et_mesos/ssh_opts',
  recipes:      ['et_mesos::master'],
  display_name: 'ssh options',
  description:  'passed to be mesos-deploy-env.sh',
  default:      '-o StrictHostKeyChecking=no -o ConnectTimeout=2'

attribute       'et_mesos/deploy_with_sudo',
  recipes:      ['et_mesos::master'],
  display_name: 'Flag whether sudo will be used in mesos deploy scripts',
  description:  'Flag whether sudo will be used in mesos deploy scripts',
  default:      '1'

attribute       'et_mesos/master_ips',
  recipes:      ['et_mesos::master'],
  display_name: 'IP list of masters',
  description:  'used in mesos-start/stop-cluster scripts.'

attribute       'et_mesos/slave_ips',
  recipes:      ['et_mesos::master'],
  display_name: 'IP list of slaves',
  description:  'used in mesos-start/stop-cluster scripts.'
