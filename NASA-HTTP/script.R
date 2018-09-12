# Carregamento das bibliotecas
library(sparklyr)
library(dplyr)

# Criação do contexto Spark
sc <- spark_connect(master = "local", spark_home = "/home/filipe/spark-2.3.1-bin-hadoop2.7/")

# Carregamento da base
logs_spk = spark_read_csv(sc, "nasa_logs", "/home/filipe/Downloads/nasa_logs.tsv", 
                          header = FALSE, columns = c("host", "timestamp", "request", 
                                                      "reply_code", "total_bytes"),
                          delimiter = "\t")

# Alguns ajustes no dataset
logs_spk = logs_spk %>% mutate(total_bytes = regexp_replace(total_bytes, "-", "0")) # troca traços no total de bytes pelo número 0
logs_spk = logs_spk %>% mutate(total_bytes = as.integer(total_bytes)) # Converte o total de bytes para inteiro
logs_spk = logs_spk %>% mutate(timestamp = regexp_replace(timestamp, ":.*", "")) # Retira as informações de hora da timestamp


# Preview do dataset
head(logs_spk)

# Hosts únicos
unique_host = logs_spk %>% group_by(host) %>% summarise(count = n()) %>%  arrange(desc(count))
count(unique_host)
head(unique_host)

# Total de erros 404
unique_reply = logs_spk %>% group_by(reply_code) %>% summarise(count = n()) %>%  arrange(desc(count))
head(unique_reply)

# 5 URLs que mais causaram erro 404
url_404 = logs_spk %>% filter(reply_code == "404") %>% group_by(host) %>% summarise(count = n()) %>%  arrange(desc(count))
head(url_404)

# Erros 404 por dia
days_404 = logs_spk %>% filter(reply_code == "404") %>% group_by(timestamp) %>% summarise(count = n()) %>%  arrange(desc(count))
head(days_404)

# Total de bytes retornados
bytes = logs_spk %>% select(total_bytes) %>% summarise(total = sum(total_bytes))