# MelissaData

Links to products/projects used:

* MelissaData Data Quality Website: [http://www.melissadata.com/dqt/index.htm](http://www.melissadata.com/dqt/index.htm)
* Vagrant: [http://vagrantup.com/](http://vagrantup.com/)
* Oracle's VirtualBox: [VirtualBox](http://www.virtualbox.org)

Ruby wrappers around the MelissaData objects. The code to access the raw
shared objects is based on the sample code provided by the MelissaData
DVDs / downloads.

## Prereqs

Make sure these are all installed on your development machine:

* Oracle's VirtualBox: [VirtualBox](http://www.virtualbox.org)
* RVM: [http://beginrescueend.com](http://beginrescueend.com)
* Ruby 1.9.2 via RVM: `rvm install 1.9.2`
* A MelissaData DVD or .dmg (e.g. IPL-DVD-2011-Q1 or DQ-DVD-2011-05)

## Quick Start

Once all the prereqs are installed, run these commands to get your local
environment setup:

    git clone git://github.com/johnnyt/melissadata.git
    cd melissadata
    rake setup

Now make sure you have your MelissaData license string and a MelissaData DVD
(or .dmg) mounted (e.g. IPL-DVD-2011-Q1), and run:

    rake md:install

Now you should be able to fire up an IRB session `irb -r melissadata`
and run:

    irb> md = MelissaData.client
    irb> md.ip '74.125.224.81'

which should return:

    => {:domain_name=>"google.com", :country_abbrev=>"US", :region=>"California", :zip=>"94043",
        :isp=>"Google Inc", :lat=>"37.386052", :country=>"United States", :city=>"Mountain View",
        :lng=>"-122.083851", :messages=>{:status=>["IP Address found in database"]}, :result_codes=>"IS01"}
