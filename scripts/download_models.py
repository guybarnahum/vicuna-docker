import argparse
from huggingface_hub import hf_hub_download

def parse_lines(lines,force=False):
   
    for line in lines:
        print(f'>{line}<')

        repo_id, file = line.split(":",2)
        print(f'repo_id:{repo_id}, file:{file}')
        
        hf_hub_download(repo_id=repo_id, 
                        filename=file, 
                        local_dir="./models",
                        #force_download=force,
                        local_dir_use_symlinks=False)
    
def main():
    parser = argparse.ArgumentParser(description='Download and Install models from huggingface')

    parser.add_argument('-f', '--file'   , help='file with model urls', default='./models.txt')
    parser.add_argument('-v', '--verbose', action='store_true') 
    parser.add_argument('--force', action='store_true', default=False, help ='re-download models') 

    args = parser.parse_args()

    if not args.file:
        print('Error: missing --file')
        parser.print_help()
        return -1
    
    print(f'Processing {args.file}')

    try:
        with open(args.file) as f:
            lines = [line.rstrip() for line in f]
            parse_lines(lines,args.force)

    except FileNotFoundError as e:
        print(f'FileNotFoundError: {str(e)}')
    
# hf_hub_download(repo_id="eachadea/ggml-vicuna-13b-4bit", filename="ggml-vicuna-13b-4bit.bin", local_dir="./models")

main()