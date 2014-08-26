node 'ip-10-0-1-120.ec2' {
  file { '/tmp/hello':
    content => "Hello, big ass world\n",
  }
}
