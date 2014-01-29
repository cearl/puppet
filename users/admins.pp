class users::admins {

  users::create { 'cbearl':
    groups => ['wheel'],
    password => 'passwordHash',
    pubkey => 'pubkeyContent',
  }
}
