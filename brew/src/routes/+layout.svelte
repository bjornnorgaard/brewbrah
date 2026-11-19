<script lang="ts">
	import './layout.css';
	import { page } from '$app/state';
	import { onNavigate } from '$app/navigation';
	import { Calculator, BookOpen, Coffee } from '@lucide/svelte';
	import ThemeToggle from '#lib/components/ThemeToggle.svelte';
	import type { LayoutProps } from './$types';

	let { children }: LayoutProps = $props();

	onNavigate((navigation) => {
		if (!document.startViewTransition) return;
		return new Promise((resolve) => {
			document.startViewTransition(async () => {
				resolve();
				await navigation.complete;
			});
		});
	});

	const tabs = [
		{ href: '/', label: 'Calculator', icon: Calculator },
		{ href: '/about', label: 'Guide', icon: BookOpen }
	];
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
			<nav class="hidden items-center gap-1 md:flex" aria-label="Main">
				{#each tabs as t (t.href)}
					<a
						href={t.href}
						class="btn btn-sm {page.url.pathname === t.href
							? 'preset-filled-primary-500'
							: 'hover:preset-tonal'}"
						aria-current={page.url.pathname === t.href ? 'page' : undefined}
					>
						{t.label}
					</a>
				{/each}
			</nav>
			<ThemeToggle />
		</div>
	</header>

	<main class="flex-1 px-4 pb-32 md:px-5 md:pb-16">
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

<!-- Mobile bottom tab bar -->
<nav
	class="fixed inset-x-0 bottom-0 z-10 border-t border-surface-200-800 bg-surface-50-950 pb-[env(safe-area-inset-bottom)] backdrop-blur-lg md:hidden"
	aria-label="Main"
>
	<ul class="mx-auto flex max-w-3xl">
		{#each tabs as t (t.href)}
			{@const active = page.url.pathname === t.href}
			<li class="flex-1">
				<a
					href={t.href}
					aria-current={active ? 'page' : undefined}
					class="flex h-16 flex-col items-center justify-center gap-1 text-xs font-medium transition-colors active:scale-95 {active
						? 'font-semibold text-surface-950-50'
						: 'text-surface-700-300'}"
				>
					<span
						class="grid h-8 w-14 place-items-center rounded-full transition-colors duration-300 {active
							? 'bg-primary-500/25'
							: ''}"
					>
						<t.icon size={20} />
					</span>
					{t.label}
				</a>
			</li>
		{/each}
	</ul>
</nav>
