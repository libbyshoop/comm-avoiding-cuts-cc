# Parallel Communication-Avoiding Minimum Cuts and Connected Components

[![DOI](https://zenodo.org/badge/114050916.svg)](https://zenodo.org/badge/latestdoi/114050916)

This is an implementation of the PPoPP 2018 "Parallel Communication-Avoiding Minimum Cuts and Connected Components" paper by

- [Pavel Kalvoda](https://github.com/PJK)
- [Lukas Gianinazzi](https://github.com/glukas)
- [Alessandro de Palma](https://github.com/AleDepo93)

It has been edited and documented by Libby Shoop, Katya Gurgel, and Hannah Detlaff.

Our setup was done on a cluster of 10 Odroid C2 nodes, all with ARM processors and running Ubuntu Mate 16.04. Steps may differ depending on your system.

We used an nfs mounted file system so that we could compile the code once on the head node and it could seen by all nodes. This is a much easier way to run MPI code. See notes below about setting up an NFS mounted pen drive or disk drive. 

## Absolutely Necessary:
- MPICH
- NFS mounted file system 
- Boost 1.64 or newer
- Cmake
- Git

## Necessary for Graph Generation:
- PaRMAT
- Networkx
- Pip3

## Optional/Helpful:
- Cluster ssh, or a similar alternative


## How to Setup:

MPICH - ON ALL NODES

Run:

```
apt-get install mpich
```

Boost - ON ALL NODES
Follow this link and download the tar.gz file https://www.boost.org/users/download/ 

Note: We installed boost 1.67

Inside the directory where you placed the tar.gz, run the following command to unzip:
```
tar -zxf ./boost_1_67_0.tar.gz
```
In order to run the bootstrap, do not go down into the tools directory, run it in boost_1_67_0 directory with
```
sudo ./bootstrap.sh
```
In the project_config.jam, created by the bootstrap script, add the line "using mpi ;" to the end of the file. IMPORTANT: There is a space before the semicolon.
Then run: ```sudo ./b2 --with-mpi --with-graph_parallel install ``` These are the two additional boost libraries used by the code that are necessary to be built separately.

You will have to fix the LD_LIBRARY_PATH in the top of your .bashrc file for your user; we placed the line “export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib” at the very top of the file.

Note: The path that you want to set LD_LIBRARY_PATH might be different depending on your system; /usr/local/lib was the default location for the placement of the boost libraries on our system.

Cmake - ON ALL NODES
```
sudo apt install cmake
```

Git - On Head Node Only 
```
sudo apt-get install git
```

PaRMAT - On Head Node Only

This is a graph generator that is used to make RMAT graphs for testing.

Go to https://github.com/farkhor/PaRMAT for the code.

Clone the repository. We did this in the home directory of our picocluster user.

Run ```make``` in the Release folder of your clone.

Note: the PaRMAT executable is now located in the Release folder.  We need to place it where all users can access it.
Still from the Release folder, copy the executable to a place in all users' PATH:

```
sudo cp PaRMAT /usr/local/bin/
```

Pip3 & Networkx - On Head Node Only

If you do not have pip3, install it with:

```sudo apt-get install python3-pip```

Install NetworkX with:

```sudo pip3 install --target=/usr/local/lib/python3.5/dist-packages/ network```

Cluster ssh - On Head Node Only

```
sudo apt-get install clusterssh
```

Having an NFS mounted file system is also absolutely necessary. Once this is set up, and all the above has been completed, go ahead and clone this repository and place the files on the NFS mounted file system.

## Necessary Changes We Made to the Original Code:
The following describes changes we made to the original code that were absolutely necessary on our system for the code to compile. If working with code cloned from our repository, note that these changes have already been completed.

Comment out or remove #include <immintrin.h> and #include <x86intrin.h> from comm-avoiding-cuts-cc/src/karger-stein/co_mincut_base_case.hpp and from karger-stein/bulk_union_find.cpp. 

Note: These lines caused compile errors when we built the code on our cluster due to system differences.

In comm-avoiding-cuts-cc/utils/io_utils.py, replace all instances of G.edges_iter() with G.edges(), as this was removed from NetworkX 2 and causes errors when running the code with that version or newer.

## Other Changes Made:
In general, adjusting the size of the problems being worked on.

Running the Code:
Run ```cmake comm-avoiding-cuts-cc``` in the directory where you placed your clone and then run ```make```. 

## NFS Mounting of a Drive
Here we show how we mount a Samsung pen drive on a picocluster of ODroid C2 cards running Ubuntu MATE 16.04. You will have to improvise off these steps for your particular microcluster.

### Head node only

After installing the flash drive, df will show you its file system name and where it was mounted. It is the 
last entry shown below:

```
picocluster@pc0:~$ df
Filesystem     1K-blocks    Used Available Use% Mounted on
udev              730764       0    730764   0% /dev
tmpfs             175860   14004    161856   8% /run
/dev/mmcblk0p2   7507936 6733700    552064  93% /
tmpfs             879296   43452    835844   5% /dev/shm
tmpfs               5120       4      5116   1% /run/lock
tmpfs             879296       0    879296   0% /sys/fs/cgroup
/dev/mmcblk0p1    130798   22676    108122  18% /media/boot
cgmfs                100       0       100   0% /run/cgmanager/fs
tmpfs             175860      36    175824   1% /run/user/1001
/dev/sda1       62656512    3712  62652800   1% /media/picocluster/Samsung USB
```
First simply unmount this so that you can gvie it a name you prefer and ensure that it is formatted for linux:

```
picocluster@pc0:~$ sudo umount /media/picocluster/Samsung\ USB
```
Format it:
```
picocluster@pc0:~$ sudo mkfs.ext4 /dev/sda -L cluster_files
mke2fs 1.42.13 (17-May-2015)
Found a dos partition table in /dev/sda
Proceed anyway? (y,n) y
Creating filesystem with 15664160 4k blocks and 3916304 inodes
Filesystem UUID: df4c9018-8268-44c6-9878-846ea3cb87fd
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
	4096000, 7962624, 11239424

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done 
```

Before mounting, we need to make a directory in /media that we will mount to. We called it /media/cluster_files, like this:
```
picocluster@pc0:~$ sudo mkdir /media/cluster_files
```

To make the mount permanent, we need to add this new directory to /etc/fstab. Add this line to the end of /etc/fstab (editing it a sudo).
```
/dev/sda /media/cluster_files ext4 defaults 0 0
```

Then we can mount that directory by having it read from /etc/fstab:
```
picocluster@pc0:~$ sudo mount /media/cluster_files
```

Now we need the install the NFS software:
```
picocluster@pc0:~$ sudo apt update
picocluster@pc0:~$ sudo apt install nfs-common nfs-kernel-server
```
Then we need to make the file system available to all machines in our cluster by adding this line to /etc/exports (editing it a sudo):

```
/media/cluster_files *(rw,sync,no_subtree_check)
```
Lastly, start the nfs service on the head node and export the file system. This will be done automatically each time you reboot after this.
```
picocluster@pc0:~$ sudo service nfs-kernel-server start
picocluster@pc0:~$ sudo exportfs -a
```

### Only on rest of the nodes in the cluster

The other nodes will be able to mount the file system by doing the following:


1. install nfs
2. make directory /media/cluster_files
3. edit fstab
4. mount -a

---------------------------------------------------------------------------------------
Beyond this point, the rest of the README is from the original fork at https://github.com/PJK/comm-avoiding-cuts-cc.

## Overview
The main C++ MPI application is located in `src`. It implements both the sparse and the dense algorithm, as well as the sequential base cases.

We also provide our experimental setup. The inputs were (partly) generated by the scripts in `input_generators`, which use the following software

 - [NetworkX](https://networkx.github.io/) (see below)
 - [PaRMAT](https://github.com/farkhor/PaRMAT)

We have also used the generators provided by Levine along with "Experimental Study of Minimum Cut Algorithms", and the real-world inputs as described in the paper. The large dense graph is generated in memory.
 
The experiments were executed on the [CSCS Piz Daint](https://www.cscs.ch/computers/piz-daint/) Cray XC50. We provide the automation scripts in `experiment_runner`. Please note that these are specific for the system and our FS layout and are only included for completeness. Before executing, be sure to adapt them to your setup.
 
## Building and running
The following dependencies are required:

 - Boost 1.64
 - C++11 compiler
 - MPI3 libraries and runtime
 - CMake 3.4+

The specific versions of software used in our experiments are detailed in the paper. Our build for Piz Daint can be reproduced by running `build_daint.sh` 

Configure and execute the build:
```
buildir=$(mktemp -d ~/tmp_build.XXXX)
pushd $buildir
cmake -DCMAKE_BUILD_TYPE=Release <PATH-TO-SOURCES>
make -j 8
popd
```

The executables will be ready in `$buildir/src/executables`. Of particular interest are the following:

- `square_root` -- our mincut implementation
- `parallel_cc` -- our CC implementation
- `approx_cut` -- our approximate mincut implementation

All of the executables are documented with the input parameters and accept inputs generated by our generators or transformed using the provided utilities.

Finally, execute the code using e.g.
```
mpiexec -n 48 <PATH>/src/executables/square_root 0.95 input.in 0
```
or equivalent for your platform. This will print the value of the resulting cut, timing information, and possibly more fine-grained profiling data.

## Experimental workflows


In our particular setup, we uploaded the sources to the cluster and performed the process described in the previous section using the `build_daint.sh` script.

Then, evaluation inputs were generated. Every input graph is contained in a single file, stored as a list of edges together with associated metadata.

For smaller experiments, this was done manually by invoking the generators, as described in the README. For the bigger experiments, we use scripts located in `input_generators` that often generate the complete set of inputs.

For example, in the *AppMC* weak scaling experiment (Figure 6 in the paper), codenamed AWX, the inputs were first generated by running
```
input_generators/awx_generator.sh
```

which outputs the graphs in the corresponding folder.

In order to execute the experiments, we run the scripts located in `experiment_runners`. Each script describes one self-contained experiment. Following our earlier example, we would run the 

```
experiment_runners/awx.sh
```


script to execute the experiment. This submits a number of jobs corresponding to the different datapoints to the scheduling system.

Every job outputs a comma-separated list of values (CSV) describing properties of execution, similar to the one shown below
```
PAPI,0,39125749,627998425,1184539166,1012658737,35015970,5382439,0.0119047
/scratch/inputs/cc1/ba_1M_16.in,5226,1,1024000,16383744,0.428972,0.011905,cc,1
```

Once all the jobs finish, we filter, merge, and copy relevant data from the cluster to a local computer using 

```
experiment_runners/pull_fresh_data.sh
```


which results in one CSV file per experiment or part of experiment. The output mirrors the input folder structure and is located in `evaluation/data`. For reference, we have included the measurements we used for the figures in this paper. These are located in `evaluation/data`.

The data is then loaded into a suite of R scripts located in `evaluation/R`. The `evaluation/R/common.R` file is perhaps of most interest, as it contains the routines that aggregate the data and verify the variance. These routines are used to build a separate analysis for every experiment. Referring back to our example experiment, the `evaluation/R/awx.R` is the script that was used to produce Figure 6.

In case the statistical significance of results is found to be unsatisfactory during this step (verified by the `verify_ci` routine found in `evaluation/R/common.R`), we repeat the experiment execution and the following steps. One presented datapoint is typically based on 20 to 100 individual measurements.


### Generators and utilities:

Interesting, albeit small graphs can be generated using the tools in `utilities`. The `cut` utility can also independently verify correctness (keep in mind that our algorithm is Monte-Carlo and all randomness is controlled by the seed).

#### Setup

Get Python 3, do `pip3 install networkx`

#### Usage

 - `cut`: Cuts a graphs from stdin
 - `generate`: Generates graphs

##### Examples

Complete graph on 100 vertices with weights uniformly distributed between 1 and 42
```
./utils/generate.py 'complete_graph(N)' 100 --weight 42 --randomize
```

Erdos-Renyi graph on 100 vertices with 0.2 edge creation probability
```
./utils/generate.py 'fast_gnp_random_graph(N, P)' 100 --prob 0.2
```

Watts–Strogatz small-world graph with `k = 6, p = 0.4` (short parameters possible)
```
./utils/generate.py 'connected_watts_strogatz_graph(N, K, P)' 100 -p 0.4 -k 6
```

Help
```
./utils/generate.py -h
```

Checking the cut value
```
./utils/generate.py 'cycle_graph(N)' 100 | ./utils/cut.py
```

Also see [the list of available generators](https://networkx.github.io/documentation/networkx-1.10/reference/generators.html]).

## License

Communication-Efficient Randomized Minimum Cuts    
Copyright (C) 2015, 2016, 2017  Pavel Kalvoda, Lukas Gianinazzi, Alessandro de Palma

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

### 3rd party license

This repository contains third-party dependencies licensed under other
licenses that remain subject to those licenses under their respective
terms and conditions. These dependencies are provided solely for 
research and experimentation purposes. The third-party dependencies are not 
a part of the "Communication-Efficient Randomized Minimum Cuts" software
and thus not subject to the license terms above.

 - [Galois](http://iss.ices.utexas.edu/?p=projects/galois)
 - [ParMETIS](http://glaros.dtc.umn.edu/gkhome/metis/parmetis/overview)
 - [Simto PRNG](http://sitmo.com/)

