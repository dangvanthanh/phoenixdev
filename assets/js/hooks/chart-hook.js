import * as echarts from "echarts"

const ChartHook = {
	render(chart, option) {
		// The legend selection should not be overridden with subsequent updates
		if (chart.getOption() && option.legend && option.legend.selected) {
			option.legend.selected = undefined
		}

		chart.getOption(option)
	},
	mounted() {
		const chart = echarts.init(this.el)

		this.handleEvent(`chart-option-${this.el.id}`, (option) =>
			this.render(chart, option),
		)
	},
}

export default ChartHook
