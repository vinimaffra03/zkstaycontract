// Define a interface do contrato
#[starknet::interface]
pub trait ISimpleStorage<TContractState> {
    fn set(ref self: TContractState, x: u128);
    fn get(self: @TContractState) -> u128;
}

// Define o módulo do contrato
#[starknet::contract]
pub mod meu_contrato {
    use starknet::storage::*;

    // Define as variáveis de armazenamento
    #[storage]
    pub struct Storage {
        stored_data: u128,
    }

    // Implementa a interface do contrato, expondo as funções públicas
    #[abi(embed_v0)]
    pub impl SimpleStorageImpl of super::ISimpleStorage<ContractState> {
        // Função externa para definir o valor de stored_data
        fn set(ref self: ContractState, x: u128) {
            self.stored_data.write(x);
        }

        // Função de visualização para recuperar o valor de stored_data
        fn get(self: @ContractState) -> u128 {
            self.stored_data.read()
        }
    }
}
