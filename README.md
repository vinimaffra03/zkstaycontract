Meu Contrato Cairo / StarkNet

Este repositório contém um contrato simples escrito em Cairo para a rede StarkNet. O contrato oferece duas funções básicas de armazenamento: set para definir um valor e get para ler o valor armazenado.

Estrutura do Projeto
MEU_PROJETO/
├── src/
│   ├── meu_contrato.cairo         ← código do contrato
│   └── lib.cairo                   ← (se você usar módulos auxiliares)
├── tests/                          ← testes (se existentes)
├── Scarb.toml                      ← configurações do projeto Cairo / StarkNet
├── snfoundry.toml                  ← configurações do ambiente de deployment / testes (Foundry)  
└── target/                         ← saída da compilação


Importante: a estrutura pode variar de acordo com sua configuração (Scarb, Foundry, etc.)

Descrição do Contrato

O arquivo meu_contrato.cairo contém:

Uma interface ISimpleStorage<TContractState> que define:

fn set(ref self: TContractState, x: u128);

fn get(self: TContractState) -> u128;

Um módulo de contrato (#[starknet::contract]) que define:

A struct de armazenamento Storage com a variável stored_data: u128.

A implementação da interface ISimpleStorage com:

fn set(...) — grava um valor em stored_data

fn get(...) — retorna o valor armazenado

Esse é um padrão clássico de contrato de armazenamento simples (similar ao “SimpleStorage” em outras blockchains).

Como Compilar

Assumindo que você esteja usando Scarb + StarkNet / Foundry:

scarb build


Isso irá compilar o contrato, gerar o sierra/bytecode, e produzir o artefato compilado na pasta target/.
Se você estiver usando StarkNet Foundry, pode haver comandos extras conforme a configuração no snfoundry.toml.

Como Testar / Interagir

Se você tiver um ambiente de testes local (ex: devnet StarkNet) ou scripts de deployment, pode fazer:

Deploy do contrato

Chamar set para armazenar um valor

Chamar get para recuperar o valor

Aqui está um exemplo hipotético (pseudo-comandos):

# Deploy
starknet deploy --contract target/compiled_contract.json --network devnet

# Chamar set
starknet invoke --address <contract_address> --abi <abi.json> --function set --inputs 42

# Chamar get
starknet call --address <contract_address> --abi <abi.json> --function get
# Deve retornar: 42

Limitações e Considerações

O contrato armazena apenas um valor u128.

Não há controle de acesso — qualquer chamador pode alterar o valor.

É um exemplo didático, não necessariamente pronto para produção sem melhorias (controle de permissões, eventos, upgradeability, testes robustos, etc.).

Convenções de Código

Use #[storage] para definições do estado do contrato.

Use #[abi(embed v0)] para expor as funções públicas/externas.

Siga convenções de indentação, nomenclatura, modularização para escalar mais contratos.

Próximos Passos

Adicionar controle de acesso (ex: owner, only_owner)

Emitir eventos quando set for chamado

Adicionar testes automatizados (ex: usando Foundry + Cairo)

Suporte a versões futuras / migrações do contrato
