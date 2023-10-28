# HPC
// Make a working directory under /scratch/[netid]/3dmhd
$ cd /scratch/ml7612/3dmhd

// Clone the source code and go to the package
$ git clone https://github.com/dsmithlasp/Rast-3dmhd.git
$ cd Rast-3dmhd

// Edit make file to make it fit to the environment
$ vi makefile
// Edit the Fortran Compiler setting
// Edit the gcc setting
// Edit the Flag compiler setting
esc :wq

// Load the module to create the batch
$ module load Intel/Openmpi/intel/4.0.5

// Gengerate a 3dmhd.exe file
make

// Check if the file exists now
ls

// Create the batch
$ touch s.sbatch
$ nano s.sbatch

// Add these code to the 3dmhd batch file
#!/bin/bash
#SBATCH --nodes=2                 # Request 1 compute node
#SBATCH --ntasks-per-node=12   # Run 64 tasks on each node
##SBATCH --cpus-per-task=1         # Use 1 compute core per task
#SBATCH --time=1:00:00            # Set the maximum runtime to 1 hour
#SBATCH --mem=80GB               # Request 180GB of memory
#SBATCH --job-name=3dmhd_test     # Set the job name
#SBATCH --output=output_file.out     # Specify the output file
#Run the code using mpirun
mpirun -np 24 ./3dmhd.exe

// Submit the file
$ sbatch s.sbatch

// Check the process status
$ seff ID

// Check for the queue status
$ squeue -u
$ Top

// control + z end

// Check the result
