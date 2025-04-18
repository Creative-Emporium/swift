# Note: If the grad_norm remains zero during training,
# please remove the `--offload_model true` parameter, or use `vllm==0.7.3`.

CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 \
NPROC_PER_NODE=8 \
swift rlhf \
    --rlhf_type grpo \
    --model Qwen/Qwen2.5-7B \
    --train_type full \
    --dataset AI-MO/NuminaMath-TIR#10000 \
    --torch_dtype bfloat16 \
    --num_train_epochs 1 \
    --max_length 2048 \
    --per_device_train_batch_size 4 \
    --per_device_eval_batch_size 4 \
    --gradient_accumulation_steps 1 \
    --eval_steps 1000 \
    --save_steps 1000 \
    --learning_rate 1e-6 \
    --save_total_limit 2 \
    --logging_steps 5 \
    --output_dir output \
    --warmup_ratio 0.05 \
    --dataloader_num_workers 4 \
    --max_completion_length 1024 \
    --reward_funcs accuracy format \
    --num_generations 32 \
    --system examples/train/grpo/prompt.txt \
    --use_vllm true \
    --vllm_gpu_memory_utilization 0.5 \
    --vllm_max_model_len 2048 \
    --deepspeed zero3 \
    --temperature 1.0 \
    --top_p 1.0 \
    --top_k 80 \
    --log_completions true \
    --num_infer_workers 8 \
    --tensor_parallel_size 4 \
    --async_generate false \
    --offload_optimizer true \
    --offload_model true \
    --gc_collect_after_offload true \
    --sleep_level 1 \
    --multi_turn_func math_tip_trick
