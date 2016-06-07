# Ansible Users

A role to manage user configuration on linux-based systems.

## Requirements

None. Well, probably Linux to run it on.

## Role Variables

* `user_users`: Array to store globally all the users on the system, for example:

```yaml
  # Required: Username of the user to create
- name: zoe
  # Optional: Defaults to present. Any value other than absent will create,
  #           absent removes the user
  state: present
  # Optional: Full name of the user
  fullname: Zoe Dog
  # Optional: The e-mail address of the user for SSH keys
  email: zoe@example.com
  # Optional: Set password if required
  password: $6$Nx...w/
  # Optional: Set the home directory for this user (deaults to /home/{name})
  home: /home/zoe
  # Optional: Should the home directory for this user be created?
  createhome: yes
  # Optional: Set the shell this user will be configured with_items
  shell: /bin/bash
  # Optional: Can be yes, no, or custom (custom is yes, but use sudo_custom
  #           options from below)
  sudo: custom
  # Optional: Add in custom sudoers lines for this user
  sudo_custom:
    # command_line is the minimum; name is the name of the user to access
    # (defaults to ALL) and nopasswd will prepend the NOPASSWD option
    - name: root
      nopasswd: yes
      command_line: /usr/bin/chmod
    - command_line: ALL
  # Optional: Overrides users_groups_default
  groups:
    - root
  # Optional: Use if SSH keys required for this user
  ssh_keys:
    # Only key is required, type by default is ssh-rsa (or as set by
    # users_ssh_key_type_default), and comment will be appended after the
    # user/e-mail if provided
    - key: AAAA...zQ==
    - type: ssh-rsa
      key: AAAA...7w==
    - type: ssh-dss
      key: AAAA...wEY=
      comment: Old Key
```

* `user_groups`: Array to store globally all the groups to be configured by this role:

```yaml
user_groups:
    # Required: Name of the group to be configured
  - name: users
    # Optional: Defaults to present. Any value other than absent will create,
    #           absent removes the user
    state: present
```

* `users_root_password`: Set the `root` user's password, if set.
* `users_root_ssh_keys`: Set the `root` user's SSH keys, if set. For example:

```yaml
users_root_ssh_keys:
    # Optional: Key type (defaults to ssh-rsa)
  - type: ssh-rsa
    # Required: The key to configure
    key: AAAA...Uf==
    # Required: Comment for the key
    comment: zoe@example.com
```

* `users_create_home`: Boolean default value on if the home directory should be created.
* `users_per_user_group`: Boolean default value on if all users should have a private group created for them as well.
* `users_group_default`: Name of the default group all users should belong. This is overidden by the username if `users_per_user_group` is set to `yes`.
* `users_groups_default`: Array of groups all users should be added to. Can be overriden on a per-user basis if required.
* `users_shell_default`: Default shell to set for all users. Can be overriden on a per-user basis if required.
* `users_sudo_default`: Should all users have `sudo` access onto the system? This will create an `/etc/sudoers.d` file per user if set, not set `/etc/sudoers`. Can be overriden on a per-user basis if required (with extra options available per-user too).
* `users_ssh_key_type_default`: Default type for all keys to be added.

Additionally,

* `list`: Normally expected in the role definition, or can be provided on a group- or host-specific basis, this is the list of users to be installed out of the global `user_users` array. For example:

```yaml
- { role: users, list: ['max','molly','sadie','charlie','zoe'] }
```

* `sudo`: Normally expected in the role definition, or can be provided on a group- or host-specific basis, this allows a local override of the sudo option. For example:

```yaml
- { role: users, list: ['maggie'], sudo: 'nopasswd' }
```

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: all
      roles:
        - { role: users, list: ['max','molly','sadie','charlie','zoe'] }
        - { role: users, list: ['maggie'], sudo: 'nopasswd' }

## License

GPLv2

## Author Information

Jonathan Wright <github@jon.than.io>
