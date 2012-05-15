class apache {
    package { 'apache2':
        ensure       => present,
    }

    service { 'apache2':
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package['apache2'],
    }

    class enable-mod-rewrite {
        exec { "a2enmod rewrite":
            path    => "/usr/bin:/usr/sbin:/bin",
            alias   => 'enable-mod-rewrite',
            creates => '/etc/apache2/mods-enabled/rewrite.load',
            notify  => Service['apache2'],
            require    => Package['apache2'],
        }
    }
    
    class enable-mod-deflate {
        exec { "a2enmod deflate":
            path    => "/usr/bin:/usr/sbin:/bin",
            alias   => 'enable-mod-deflate',
            creates => '/etc/apache2/mods-enabled/deflate.load',
            notify  => Service['apache2'],
            require    => Package['apache2'],
        }
    }
    
    class enable-mod-status {
        exec { "a2enmod status":
            path    => "/usr/bin:/usr/sbin:/bin",
            alias   => 'enable-mod-status',
            creates => '/etc/apache2/mods-enabled/status.load',
            notify  => Service['apache2'],
            require => Package['apache2'],
        }
    }
    
    class php5 {
        package { 'php5':
            ensure => present,
            notify => Exec['enable-mod-php5'],
        }
    
        exec { "a2enmod php5":
            path        => "/usr/bin:/usr/sbin:/bin",
            alias       => 'enable-mod-php5',
            refreshonly => true,
            notify      => Service['apache2'],
        }
    }

    class php5-mysql {
        package { 'php5-mysql':
            ensure  => present,
            require => Package['php5'],
            notify  => Service['apache2'],
        }
    }

    
    class php5-pgsql {
        package { 'php5-pgsql':
            ensure  => present,
            require => Package['php5'],
            notify  => Service['apache2'],
        }
    }
    
    class php5-ldap {
        package { 'php5-ldap':
            ensure  => present,
            require => Package['php5'],
            notify  => Service['apache2'],
        }
    }

    class php5-gd {
        package { 'php5-gd':
            ensure  => present,
            require => Package['php5'],
            notify  => Service['apache2'],
        }
    }
}

# vim: set ts=4 sw=4 et:
