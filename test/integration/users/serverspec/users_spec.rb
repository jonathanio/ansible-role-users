require 'serverspec'

# Required by serverspec
set :backend, :exec

describe group('staff') do
  it { should exist }
end

describe group('users') do
  it { should exist }
end

describe group('max') do
  it { should exist }
end

describe user('max') do
  it { should exist }
  it { should belong_to_group 'max' }
  it { should belong_to_group 'staff' }
  it { should_not belong_to_group 'users' }
  it { should have_login_shell '/bin/bash' }
  its(:encrypted_password) { should match /^\$[3-6]\$[^\$\n\r]{1,16}\$.{1,86}$/ }
end

describe file('/etc/sudoers.d/max') do
  it { should be_file }
  it { should exist }
  it { should be_mode 640 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'max ALL=(ALL) ALL' }
end

describe group('molly') do
  it { should exist }
end

describe user('molly') do
  it { should exist }
  it { should belong_to_group 'molly' }
  it { should belong_to_group 'staff' }
  it { should_not belong_to_group 'users' }
  it { should have_login_shell '/bin/zsh' }
  its(:encrypted_password) { should match /^\$[3-6]\$[^\$\n\r]{1,16}\$.{1,86}$/ }
end

describe file('/etc/sudoers.d/molly') do
  it { should be_a_file }
  it { should exist }
  it { should be_mode 640 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'molly ALL=(ALL) NOPASSWD:ALL' }
end

describe group('sadie') do
  it { should exist }
end

describe user('sadie') do
  it { should exist }
  it { should belong_to_group 'sadie' }
  it { should belong_to_group 'staff' }
  it { should_not belong_to_group 'users' }
  its(:encrypted_password) { should match /^\$[3-6]\$[^\$\n\r]{1,16}\$.{1,86}$/ }
end

describe file('/etc/sudoers.d/sadie') do
  it { should_not exist }
end

describe group('charlie') do
  it { should_not exist }
end

describe user('charlie') do
  it { should_not exist }
end

describe file('/etc/sudoers.d/charlie') do
  it { should_not exist }
end

describe group('zoe') do
  it { should exist }
end

describe user('zoe') do
  it { should exist }
  it { should belong_to_group 'zoe' }
  it { should_not belong_to_group 'staff' }
  it { should_not belong_to_group 'users' }
  it { should belong_to_group 'root' }
  its(:encrypted_password) { should match /^\$[3-6]\$[^\$\n\r]{1,16}\$.{1,86}$/ }
end

describe file('/etc/sudoers.d/zoe') do
  it { should be_a_file }
  it { should exist }
  it { should be_mode 640 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it {
    should contain 'zoe ALL=(root) NOPASSWD:/usr/bin/chmod'
    should contain 'zoe ALL=(ALL) ALL'
  }
end

describe file('/home/zoe/.ssh') do
  it { should be_a_directory }
  it { should exist }
  it { should be_mode 700 }
  it { should be_owned_by 'zoe' }
  it { should be_grouped_into 'zoe' }
end

describe file('/home/zoe/.ssh/authorized_keys') do
  it { should be_a_file }
  it { should exist }
  it { should be_mode 600 }
  it { should be_owned_by 'zoe' }
  it { should be_grouped_into 'zoe' }
  it {
    should contain 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD1N9uJAGA42v0vrve+X005d8ls7Cq2Q+cZKQclT2uOexr5qmwNjTiLw8XQBkvyYUHNeljQxi+p1eUzPX7hWDBdGXjN7w303Be1IUvD9Zmc1I1gMb2uFRu+5KdruSP2ncfCkWrXPkVSnA31ostV0ARkwpWhZ1mFZpudCDPNS+lWxcsj1GspW+s8+7eKQ4hTull9S//X2YmIBiXXAbjAsyPIeTZIQ1DZgEMcTcRCbKeEZOTgbhL3iNfKP17XksUGF6KJlhgNYalNW3VR7pdB1qqM6VUBuPkuxtTJmLzQ1GAJMYouF9thkdcz8VRJekLRuA5yi9wa4qVRQ8/vqHlDRxWRYeILazjpXVnjFZbY79ES4thdxeOKz+PG95MCLCoPmcIEENbKZO1r9qHUvxHwKpkyiAsdnovBnaagQSvdFRUmVW/33zGWfZ0v0xR6h/zABbaB1h1TltljTp80ylwaf29OHyGBxa6RHpIptaAF0+a6Gn+uMwtZaKco5ixNDgeqS2XKO/Hy3UhVw2mH9fomrezFkXSvtn1NUe/xutP8UKSiTBz8gaFWPH3OP9cUI/xpvTJ4gILTzTvCpvBliW51lsPoQv8MHUxKSVlo050nS7u2lJi+zMx+uMkEOhFosbQOlPiCVHZ/eePGTQyYsAMEkkViC/8Yi3eX3800vSEbGsmYzQ== zoe@example.com'
    should contain 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCymOP7K7eUESvuegkivLMlDv3w2kWH0NfIjM9OxtAxrlbCdGFoxPpEqSHmiC0WEshSmh9jM5k4DPXUP/RZxl6itMOxDXpmDGxju/kIr5JpT7X5H74ztkImnnXjqncoYvC4hgwA/l/rML6yphNXQQw4ueBTpCIj/HRMIo3iqwJq0iBlfBfCxN7OyDs0KB/f9+f6VktFkxxNfYf6y7Dj/6g3WIqzpwkKM7qKPlirYS1jWHiF2tgzb1kWER5QgXsmWz2iIIZOzUb9sz0l69s6n2EEUVgHyyl5gpFpb737GZgLNILBMGRkgu7IW/jyhUcGVrFf5BkRx8DBgYCkBjO1j5mHaI3ypzyrSAOKKCW+1l8mZGkZEnq1+XrLELkqremiYWrQVrbSFrJyT1QzbCyBGqrvZrAWdOp9hrmN5m658SRQsIhB3Ol6+fupHAQO+05iHza3YME/tk/FUeEUzpCkU94X24h3yRzvcbUpGuSlGCUNxTXwTzitTPXamnye5ChjdhSNdAvTVLzdhpri3oZiVSa2MnX9whK/wLx6Zv+43H4hTATpVjf+jqQYoxOcw0qBoL9hBckatD32MFqgZpHWlCVLPTwhyHua9JuX2Wn4UTRnaF7j0a3/FRa4z22M2a8yzGnlt3+LtIVOHDAVvpqx2LYFzFJQY41SuukkJ7OFhZXU7w== zoe@example.com'
    should contain 'ssh-dss AAAAB3NzaC1kc3MAAACBANIC6DutC/QMgYQOW+kgBKxCCR8VoijwMuwi4h/kcn8R/5aLY6BRFYX59VaJ+yVXZTD0vIDq0oN4iYhcEh3uKVg/LITLGdnZ71sKE+NJgavaemc4kbHZ6Z3pRF/m9gdRqMnWN4KfchoSy9Ho+hf8zQicvqEOt4wwDwpvPYLdhgx5AAAAFQCx+KDUykliz8PvjPTCES0Q2R/cewAAAIA0A7iEfRzNTOfuBsxMkEIFqgffpVfjkujkv0aovO7Dnj25UtQPD0kLj9tFtWO8nv4UDPcbUcuwhQgDyS7tKZeeeVYtz0npKphs2Fkxnq8MiJEU22IjhXcH/6gyaYwGmQ8WKeq5U3y37e9fkTuuZjavmrIKOONUPxZnphKrewCFPgAAAIEAwqnD6taLOvYKuaaXBiuEFhSo/hIQ+Qf0gFN+IZyVDpe/lQR7tEmvH2vRFVMQvST2No0sybdOErkcuI2w4zWnL4n9uVQgxLx0ZaYg1zGFFxOvcHZnGOaoz963VpQVp+ZH2ePD5P8uX4CP8joCqJBc1rm4TdB2/VtBEYAXrVKFwEY= zoe@example.com (Old Key)'
  }
end

describe group('maggie') do
  it { should exist }
end

describe user('maggie') do
  it { should exist }
  it { should belong_to_group 'maggie' }
  it { should belong_to_group 'staff' }
  it { should_not belong_to_group 'users' }
  its(:encrypted_password) { should match /^\$[3-6]\$[^\$\n\r]{1,16}\$.{1,86}$/ }
end

describe file('/etc/sudoers.d/maggie') do
  it { should_not exist }
end

describe group('lola') do
  it { should_not exist }
end

describe user('lola') do
  it { should_not exist }
end

describe file('/etc/sudoers.d/lola') do
  it { should_not exist }
end
