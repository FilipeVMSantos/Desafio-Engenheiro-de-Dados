# Desafio Engenheiro de Dados

Neste projeto está a resolução do desafio Engenharia de Dados da Sematix.

O projeto contém duas pastas:

 * **Questões** - Resolução das questões teóricas em um arquivo PDF
 * **NASA-HTTP** - Análise exploratória do dataset de acessos ao servidor da NASA
 
 A análise foi desenvolvida utilizando o Apache Spark e a linguagem R. Foram utilizadas as seguintes bibliotecas:
 
 * sparklyr
 * dplyr
 
 O sparklyr fornece o SparkContext e as funções de comunicação com o Spark. O dplyr, as funções para manipulação de dados.
 
 A base original é disponibilizada em dois arquivos chamados "access_log_Jul95" e "access_log_Aug95". Será criado um novo arquivo chamado "nasa_logs.tsv" a partir da concatenação dos dois arquivos originais. Essa junção é feita executando o seguinte comando no shell do Linux:

```
$cat access_log_Jul95 access_log_Aug95 > nasa_logs.tsv
```
Os dados originais apresentam o seguinte formato:
```
199.72.81.55 - - [01/Jul/1995:00:00:01 -0400] "GET /history/apollo/ HTTP/1.0" 200 6245
```
Para facilitar a manipulação dos dados o arquivo será transformado para o formato tsv, ou seja, os valores serão separados por TAB (\\t). Para fazer essas tranformações, são executados os seguintes comandos no shell do Linux:

```
# Coloca \t entre o valor do host e da timestamp
$sed -Ei 's/\s-\s-\s\[/\t/' nasa_logs.tsv

# Coloca \t entre o valor da timestamp e da requisição
$sed -Ei 's/\] \"/\t\"/' nasa_logs.tsv

# Coloca \t entre o valor da requisição e do código de retorno
$sed -Ei 's/\" ([0-9]{3})/\"\t\1/' nasa_logs.tsv 

# Coloca \t entre o valor do código de retorno e os bytes retornados
$sed -Ei 's/([0-9]{3}) /\1\t/' nasa_logs.tsv

``` 

 O arquivo principal do projeto é o **Nasa-HTTP-exploration.Rmd** que é um R notebook que pode ser aberto utilizando a IDE Rstudio. Na pasta está presente também duas versões já compiladas do R notebook: HTML e em PDF.
 
 A pasta também contém o arquivo **script.R** que contém as mesmas funções executadas no R notebook em um script R puro.
 
 Os arquivos **Nasa-HTTP-exploration.Rmd** e **script.R** foram feitos utilizando a codificação UTF-8.
