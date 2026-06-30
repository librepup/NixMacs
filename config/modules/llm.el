(require 'llm-ollama)

(setq ellama-provider
      (make-llm-ollama
       :host "127.0.0.1"
       :port 11434
       :chat-model "qwen3.5:9b"
       :embedding-model "qwen3.5:9b"))

(setopt ellama-auto-scroll t)
