from llama_cpp import Llama
import copy
import json
import sys


print("Loading model...")
#llm = Llama(model_path="/mnt/d/Workspaces/Git Local Repo/LLM Python Interface/models/synthia-7b-v2.0.Q4_K_M.gguf", 
#            verbose=True, n_gpu_layers=32, n_threads=6, n_ctx=512, n_batch=1024)


model = "synthia-7b-v2.0.Q4_K_M.gguf"

if(sys.argv[0] == "GPU"):
    llm = Llama(model_path=f"./models/{model}", 
            verbose=True, n_gpu_layers=32, n_threads=6, n_ctx=512, n_batch=1024)
else:
    llm = Llama(model_path=f"./models/{model}", 
            verbose=False)

print("Model loaded")



running=True

while(running):
    #print("Q: ", end="")
    
    userQuestion = input("Q: ")
    #print("Q: " + userQuestion)

    if userQuestion.upper() == "EXIT":
        running = False
    
    
    if running:
        output = llm(
        "Q: " + userQuestion + '▌',
        max_tokens=131072,
        temperature=0.8,
        echo=False,
        stream=True,
        stop='▌'
        )

        
        #print(output['choices'])
        print("==============================")
        for line in output:
            print(line['choices'][0]['text'], end="")
            #print(line)
        print("\n==============================")

        llm.reset()
    
    else:
        print("Exiting...")




# for line in output:
#     CompletionFragment = copy.deepcopy(line)
#     print(CompletionFragment['choices'])
