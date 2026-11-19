<script lang="ts">
	import { Tween } from 'svelte/motion';
	import { cubicOut } from 'svelte/easing';

	let { value, decimals = 0 }: { value: number; decimals?: number } = $props();

	const tween = Tween.of(() => value, { duration: 450, easing: cubicOut });
</script>

<span class="tabular-nums" data-value={value}>{tween.current.toFixed(decimals)}</span>
