#!/usr/bin/env bash

model_path=$1
model_id=$2
bench_name="mt_bench"
max_new_tokens=$3
num_choices=$4
num_gpus_per_model=$5
num_gpus_total=$6
max_gpu_memory=$7
dtype=$8
answer_dir_root=$9
judge_model=${10}
baseline_model=${11}
mode=${12}

cd fastchat/llm_judge

python gen_model_answer.py \
    --model-path $model_path \
    --model-id $model_id \
    --bench-name $bench_name \
    --num-choices $num_choices \
    --num-gpus-per-model $num_gpus_per_model \
    --num-gpus-total $num_gpus_total \
    --max-gpu-memory $max_gpu_memory \
    --dtype $dtype \
    --answer-dir-root $answer_dir_root
python gen_judgment.py \
    --bench-name $bench_name \
    --model-list $model_id \
    --judge-model $judge_model \
    --baseline-model $baseline_model \
    --mode $mode \
    --parallel 16 \
    --answer-dir-root $answer_dir_root

python show_result.py \
    --bench-name $bench_name \
    --model-list $model_id \
    --judge-model $judge_model \
    --baseline-model $baseline_model \
    --mode $mode \
    --answer-dir-root $answer_dir_root