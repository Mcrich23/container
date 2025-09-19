


import ArgumentParser
import ContainerClient
import ContainerPersistence
import ContainerizationError
import Foundation

extension Application {
    struct PropertyGet: AsyncParsableCommand {
        static let configuration = CommandConfiguration(
            commandName: "get",
            abstract: "Retrieve a property value"
        )

        @OptionGroup
        var global: Flags.Global

        @Argument(help: "the property ID")
        var id: String

        func run() async throws {
            let value = DefaultsStore.allValues()
                .filter { id == $0.id }
                .first
            guard let value else {
                throw ContainerizationError(.invalidArgument, message: "property ID \(id) not found")
            }

            guard let val = value.value?.description else {
                return
            }

            print(val)
        }
    }
}
