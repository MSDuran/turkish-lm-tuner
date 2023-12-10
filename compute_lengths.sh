#!/bin/bash
#SBATCH --job-name=compute_lengths
#SBATCH --mail-type=ALL
#SBATCH --output=outs/%j.log
#SBATCH --mail-user=username@gmail.com
#SBATCH --container-image ghcr.io\#bouncmpe/cuda-python3
#SBATCH --container-mounts /stratch/bounllm/:/stratch/bounllm/
#SBATCH --time=7-00:00:00
#SBATCH --gpus=1
#SBATCH --cpus-per-gpu=8
#SBATCH --mem-per-gpu=40G

echo $1
echo $2

source /opt/python3/venv/base/bin/activate

pip install torch --index-url https://download.pytorch.org/whl/cu118
cd ~/t5-tuner
pip install -r requirements.txt
if [ "$3" == "--no-preprocess" ]; then
    python src/compute_lengths.py --dataset_name $1 --task $2 --no-preprocess
else
    python src/compute_lengths.py --dataset_name $1 --task $2
fi
