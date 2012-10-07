===Getting Started===

Make sure to download [Virtualbox](https://www.virtualbox.org/wiki/Downloads). Then you can run `bundle` to install all the gems and `vagrant up` when that's done to start the VM build.

    bundle --path vendor/bundle --binstubs
    bundle exec vagrant basebox build rinxter # Download the iso
    bundle exec vagrant up
    bundle exec vagrant ssh # if you want to check out the contents

The box will install Java, Tomcat and other prerequisites and then start Rinxter as a service running at http://localhost:8081.
