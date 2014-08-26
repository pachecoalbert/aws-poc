file { '/tmp/redshirt':
	ensure => "directory",
}

file { '/tmp/redshirt/logan':
	ensure => "present",
}
