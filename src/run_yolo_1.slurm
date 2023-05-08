#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
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
python test.py --data data/coco.yaml --img 640 --batch 32 --conf 0.001 --iou 0.65 --device 0 --weights runs/train/yolov7_reproduct/weights/best.pt --name yolov7_640_val
"
# python train.py --workers 8 --device 0 --epoch 10 --batch-size 16 --data data/coco.yaml --img 640 640 --cfg cfg/training/yolov7.yaml --weights '' --name yolov7_reproduct --hyp data/hyp.scratch.p5.yaml