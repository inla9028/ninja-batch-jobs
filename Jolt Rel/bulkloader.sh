#!/bin/sh
java -classpath .:/usr/lib/classes.zip:/usr/local/tuxedo/udataobj/jolt/jolt.jar:/usr/local/tuxedo/udataobj/jolt/joltadmin.jar bea.jolt.admin.jbld -p NINJA //bpet:22125 $1

