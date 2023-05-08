#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2:00:00
#SBATCH --mem=128GB
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --job-name=myTest
#SBATCH --mail-type=END
#SBATCH --mail-user=yp2201@nyu.edu
#SBATCH --output=slurm_%j.out

## make sure you change the folder path, and file path
module purge    
singularity exec --nv --bind $SCRATCH/yolov7 --overlay $SCRATCH/overlay-25GB-500K.ext3:ro \
            /scratch/work/public/singularity/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif /bin/bash -c "
source /ext3/env.sh
conda activate
cd $SCRATCH/yolov7
python detect.py --weights runs/train/yolov7_pascal4/weights/best.pt  --conf 0.25 --img-size 640 --source cv_image.mp4
"