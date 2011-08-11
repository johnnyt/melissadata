# MelissaData

Links to products/projects used:

* MelissaData Data Quality Website: [http://www.melissadata.com/dqt/index.htm](http://www.melissadata.com/dqt/index.htm)
* Vagrant: [http://vagrantup.com/](http://vagrantup.com/)
* Oracle's VirtualBox: [VirtualBox](http://www.virtualbox.org)

Ruby wrappers around the MelissaData objects. The code to access the raw
shared objects is based on the sample code provided by the MelissaData
DVDs / downloads.

## Quick Start

First, make sure your development machine has [VirtualBox](http://www.virtualbox.org)
installed. Then to get the Ruby environment set up, run:

    git clone git://github.com/johnnyt/melissadata.git
    cd melissadata
    rake setup

Then make sure you have a lucid64 Vagrant base box on your machine:

    bundle exec vagrant box add lucid32 http://files.vagrantup.com/lucid32.box
or
    bundle exec vagrant box add lucid64 http://files.vagrantup.com/lucid64.box


Now fire up and provision the Vagrant VM:

    bundle exec vagrant up

Once that is done, make sure you have a MelissaData DVD (or .dmg) mounted, and run:

    bundle exec vagrant md install

Then SSH into the Vagrant VM:

    bundle exec vagrant ssh

Once logged into the VM - run:

    cd /opt/melissadata/gem
    irb -r lib/md

Inside the IRB session run:

    irb> ip = MelissaData::NativeObject::IpLocator.new :license => 'YOUR_LICENSE_KEY'
    irb> ip.process :ip => '74.125.224.81'

which should return:

    => {:domain_name=>"google.com", :country_abbrev=>"US", :region=>"California", :zip=>"94043", :isp=>"Google Inc", :lat=>"37.386052", :country=>"United States", :city=>"Mountain View", :lng=>"-122.083851", :messages=>{:status=>["IP Address found in database"]}, :result_codes=>"IS01"}
