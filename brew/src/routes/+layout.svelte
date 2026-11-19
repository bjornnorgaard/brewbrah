<script lang="ts">
	import './layout.css';
	import { Coffee } from '@lucide/svelte';
	import ThemeToggle from '#lib/components/ThemeToggle.svelte';
	import type { LayoutProps } from './$types';

	let { children }: LayoutProps = $props();
</script>

<div class="mx-auto flex min-h-dvh max-w-3xl flex-col">
	<header
		class="flex items-center justify-between px-4 pt-[max(1rem,env(safe-area-inset-top))] pb-2 md:px-5 md:pt-8"
	>
		<a href="/" class="flex items-center gap-2 text-2xl font-bold tracking-tight">
			<Coffee size={26} class="text-primary-500" />
			<span class="flex items-baseline gap-1.5">
				brew
				<span class="font-byline text-base font-normal tracking-normal text-surface-700-300 italic">
					by bear
				</span>
			</span>
		</a>
		<div class="flex items-center gap-2">
			<ThemeToggle />
		</div>
	</header>

	<main class="flex-1 px-4 pb-[max(2.5rem,env(safe-area-inset-bottom))] md:px-5 md:pb-16">
		{@render children()}
	</main>

	<footer class="hidden px-5 pb-8 text-center text-sm text-surface-700-300 md:block">
		brew · made with care ·
		<a
			class="font-semibold text-surface-950-50 underline"
			href="https://github.com/bjornnorgaard/brewbrah"
		>
			source
		</a>
	</footer>
</div>
