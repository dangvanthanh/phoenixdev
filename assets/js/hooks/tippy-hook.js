import tippy from "tippy.js"

const TippyHook = {
	mounted() {
		this.instance = tippy(this.el)
	},
	updated() {
		this.instance.setProps(
			Object.fromEntries(this.el.dataset)
				.filter(([k]) => k.startsWith("tippy"))
				.map(([k, v]) => [this.tippyPropName(k), v]),
		)
	},
	destroyed() {
		this.instance.destroy()
	},

	tippyPropName(k) {
		const strippedName = k.replace("tippy", "")
		return `${strippedName.charAt(0).toLowerCase()}${strippedName.slice(1)}`
	},
}

export default TippyHook
