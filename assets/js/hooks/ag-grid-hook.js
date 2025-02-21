import * as agGrid from "ag-grid-community"
import { AllCommunityModule, ModuleRegistry } from "ag-grid-community"

ModuleRegistry.registerModules([AllCommunityModule])

const ColumnTypes = {
	numericThousandSeparator: {
		valueFormatter: (params) =>
			new Intl.NumberFormat("en-US").format(params.value),
	},
	airport_links: {
		cellRenderer: (params) => {
			if (!Array.isArray(params.value)) return params.value

			const container = document.createElement("div")
			container.className = "flex flex-row space-x-2 mt-1.5"

			params.value?.forEach((code, _) => {
				const button = document.createElement("button")
				button.className =
					"px-2 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 text-sm"

				const link = document.createElement("a")
				link.href = `https://www.google.com/search?q=${code} airport`
				link.target = "_blank"
				link.textContent = code

				button.appendChild(link)
				container.appendChild(button)
			})

			return container
		},
	},
	array_length_comparator: {
		comparator: (valueA, valueB) => {
			if (!valueA || !valueB) return 0
			if (Array.isArray(valueA) && Array.isArray(valueB)) {
				return valueA.length - valueB.length
			}
			return valueA - valueB
		},
	},
}

const AgGridHook = {
	mounted() {
		this.handleEvent("load-grid", (serverOptions) => {
			const gridOptions = {
				columnTypes: ColumnTypes,
				...serverOptions,
			}

			agGrid.createGrid(document.getElementById(this.el.id), gridOptions)
		})
	},
}

export default AgGridHook
