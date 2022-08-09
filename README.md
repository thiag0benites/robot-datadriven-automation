# Configurando ambiente do Data Manager

## 1. Instalando Docker
### 1.1 Instalando Docker no Windows
Documentação oficial:
https://docs.docker.com/desktop/install/windows-install/

### 1.2 Instalando Docker no Linux
Documentação oficial:
https://docs.docker.com/desktop/install/linux-install/

## 2. Ambiente PHP/MYSQL com docker-compose
Ambiente criado de uma composição de dois containers:
- PHP 7.4;
- MYSQL (Última versão disponível).

Utilizado para **_hospedar_** o **_Data Manager_** de automação.

### 2.1 Data Manager
Frontend de apoio no gerenciamento manual de dados e execuções pontuais dos testes automatizados.

## 3. Subir Ambiente Pela Primeira Vez
```docker
# Subir container pela primeira vez. 
# (-d: modo background não prende o terminal)
docker-compose up -d

# Verifica os container "UP".
docker ps

# Instalar os conectores MYSQL no PHP
docker-compose exec php docker-php-ext-install pdo pdo_mysql mysqli

# Reiniciar os containers
docker-compose restart
```
### 3.1 Executar e Parar Ambiente
Após a excução dos comandos **"3. Subir Ambiente Pela Primeira Vez"** os container já estão configurados usar:
```docker
# Parar containers
docker-compose stop

# Iniciar containers
docker-compose start
```

### 3.2 Destruir Ambiente
```docker
# Matar os containers
docker-compose down
```
OBS: Após a execução do comando os containers do ambiente serão "destruidos". Para recriá-los execute novamente os comandos de "Subir Ambiente Pela Primeira Vez".

## 4. Guia Comandos Docker Úteis
| **Comando**                        | **Descrição**                                                                        |
|--                                  |--                                                                                    |
| docker ps                          | lista contêineres ativos                                                             |
| docker ps -a                       | lista contêineres ativos e inativos                                                  |
| docker container rm <container ID> | Remove contêineres                                                                   |
| docker-compose up                  | cria e inicia os contêineres                                                         |
| docker-compose build               | realiza apenas a etapa de build das imagens que serão utilizadas                     |
| docker-compose logs                | visualiza os logs dos contêineres                                                    |
| docker-compose restart             | reinicia os contêineres                                                              |
| docker-compose ps                  | lista os contêineres                                                                 |
| docker-compose scale               | permite aumentar o número de réplicas de um contêiner                                |
| docker-compose start               | inicia os contêineres                                                                |
| docker-compose stop                | paralisa os contêineres                                                              |
| docker-compose down                | paralisa e remove todos os contêineres e seus componentes como rede, imagem e volume |

# Selenoid
## 1. Download

## 1.2. Intalacao
Na pasta do projeto executar:
```docker
# Inicia driver
./selenoid.exe selenoid start --vnc

# Inicia UI (frontend)
./selenoid.exe selenoid-ui start

# Para o selenoid
./selenoid.exe selenoid stop
```

## 5. Referências
    Canal Fernando Anselmo
    - https://www.youtube.com/watch?v=axU9eEcwfDU&ab_channel=FernandoAnselmo
