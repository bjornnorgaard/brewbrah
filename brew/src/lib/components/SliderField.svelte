<script lang="ts">
	import { Slider } from '@skeletonlabs/skeleton-svelte';
	import { Minus, Plus } from '@lucide/svelte';
	import { clamp, round } from '#lib/brew.ts';

	let {
		label,
		unit,
		value = $bindable(),
		min,
		max,
		step,
		prefix = '',
		marks = [],
		id
	}: {
		label: string;
		unit: string;
		value: number;
		min: number;
		max: number;
		step: number;
		prefix?: string;
		/** Quick-pick indicators below the track. Tap one to jump to it. */
		marks?: { value: number; label?: string }[];
		id: string;
	} = $props();

	function nudge(dir: 1 | -1) {
		value = round(clamp(value + dir * step, min, max), 2);
		navigator.vibrate?.(8);
	}

	function pick(v: number) {
		value = v;
		navigator.vibrate?.(8);
	}

	function onInput(e: Event) {
		const n = (e.currentTarget as HTMLInputElement).valueAsNumber;
		if (Number.isFinite(n)) value = clamp(n, min, max);
	}
</script>

<div class="space-y-3">
	<div class="flex items-end justify-between gap-3">
		<label for={id} class="text-sm font-medium text-surface-700-300">{label}</label>
		<div class="flex items-baseline gap-1">
			{#if prefix}<span class="text-lg text-surface-600-400">{prefix}</span>{/if}
			<input
				{id}
				type="number"
				inputmode="decimal"
				{min}
				{max}
				{step}
				{value}
				oninput={onInput}
				class="[field-sizing:content] max-w-28 min-w-[2ch] [appearance:textfield] border-0 border-b-2 border-transparent bg-transparent px-0 py-0 text-right text-3xl font-semibold tabular-nums transition-colors focus:border-primary-500 focus:ring-0 [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none"
			/>
			<span class="w-8 text-sm text-surface-600-400">{unit}</span>
		</div>
	</div>

	<div class="flex items-start gap-1.5 md:gap-3">
		<button
			type="button"
			class="btn-icon size-11 shrink-0 preset-tonal transition-transform active:scale-90"
			aria-label="Decrease {label}"
			onclick={() => nudge(-1)}
		>
			<Minus size={20} />
		</button>

		<Slider
			class="flex-1"
			value={[value]}
			{min}
			{max}
			{step}
			onValueChange={(e) => (value = e.value[0])}
			aria-label={[label]}
		>
			<Slider.Control class="relative flex h-11 w-full touch-none items-center">
				<Slider.Track class="h-2.5 w-full rounded-full bg-surface-200-800">
					<Slider.Range class="h-full rounded-full bg-primary-500" />
				</Slider.Track>
				<Slider.Thumb
					index={0}
					class="size-7 rounded-full bg-primary-500 shadow-lg ring-4 ring-primary-500/25 transition-[box-shadow,transform] focus-visible:ring-8 data-[dragging]:scale-110 data-[dragging]:ring-8"
				>
					<Slider.HiddenInput />
				</Slider.Thumb>
			</Slider.Control>
			{#if marks.length}
				<Slider.MarkerGroup class="relative mb-1 h-9" aria-hidden="false" data-testid="{id}-marks">
					{#each marks as m (m.value)}
						{@const reached = m.value <= value}
						<Slider.Marker value={m.value} class="flex flex-col items-center">
							<span
								class="h-2 w-0.5 rounded-full transition-colors duration-300 {reached
									? 'bg-primary-500'
									: 'bg-surface-400-600'}"
							></span>
							{#if m.label}
								<button
									type="button"
									class="pointer-events-auto -mt-0.5 min-h-8 min-w-6 rounded-md px-1 text-[11px] font-medium whitespace-nowrap transition-colors active:scale-90 {value ===
									m.value
										? 'bg-primary-500 text-primary-contrast-500'
										: 'text-surface-700-300 hover:preset-tonal'}"
									aria-label="Set {label} to {m.label}"
									onclick={() => pick(m.value)}
								>
									{m.label}
								</button>
							{/if}
						</Slider.Marker>
					{/each}
				</Slider.MarkerGroup>
			{/if}
		</Slider>

		<button
			type="button"
			class="btn-icon size-11 shrink-0 preset-tonal transition-transform active:scale-90"
			aria-label="Increase {label}"
			onclick={() => nudge(1)}
		>
			<Plus size={20} />
		</button>
	</div>
</div>
