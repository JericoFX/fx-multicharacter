<script lang="ts">
	import {createEventDispatcher} from 'svelte';
	import {fade, slide} from 'svelte/transition';
	const dispatch = createEventDispatcher();
	export let open = false;
	const closeModal = () => {
		open = false;
		dispatch('Close', {open});
	};

	const Data = [
		{
			id: 1,
			name: 'Migrant',
			img: 'https://www.pngmart.com/files/17/GTA-Characters-PNG-Image.png',
			description: 'The role of migrant is really for those who are not American and who wisth to arrive incognito, having the papers will be difficult. But maybe you want to stay in the shadows?',
		},
		{
			id: 2,
			name: 'Citizen',
			img: 'https://www.kindpng.com/picc/b/224-2246750_grand-theft-auto-png.png',
			description: 'The citizen must be American, he is legal, but can change. The latter have an easy life, but everyone knows him. Is the best way to succeed?',
		},
		{
			id: 3,
			name: 'expatriate',
			img: 'https://www.pngitem.com/pimgs/b/791-7915656_gta-v-characters-png.png',
			description: 'The Expatriate and for those who do not yet know where to turn and who are not of American nationality,they would lean more towards the legal.',
		},
	];
	$: ss = 0;
</script>

{#if open}
	<div class="modal-overlay" transition:fade={{duration: 100}}>
		<div class="my-back fit" />
		<div class="modals absolute-center">
			<div class="sasd full-height" style="display:flex;justify-content:space-between;">
				{#each Data as modal}
					<div class="cards flex relative-position q-px-sm q-mx-sm" on:click={() => (ss = modal.id)}>
						<img class:colorinche={ss === modal.id ? true : false} src={modal.img} alt="" />
						{#if ss === modal.id}
							<div transition:slide={{duration: 500}}>
								<p class="text-center absolute-bottom" transition:slide={{duration: 500}}>
									{modal.description}
									<br />
									<button class="q-mt-md">Select</button>
								</p>
								<p class="absolute-top text-center text-h4" transition:slide={{duration: 500}}>
									<span>
										{modal.name}
									</span>
								</p>
							</div>
						{/if}
					</div>
				{/each}
			</div>
			<button on:click={closeModal} class="btn fixed-bottom" style="left:43%">Select</button>
		</div>
	</div>
{/if}

<style>
	.modals {
		position: absolute;
		width: 100vw;
		height: 90%;
		background: rgba(23, 23, 23, 0.8);
		box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.59);
		border-radius: 10px;
	}
	.my-back {
		background-color: rgba(255, 255, 55, 0.0001) !important;
	}
	.modal-overlay {
		z-index: 1000;
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: #00000080 !important;
	}
	.cards {
		width: 30%;
		height: auto;
		background: rgba(23, 23, 23, 0.8);
		border-radius: 0.8vh;
		margin: 3vh;
	}
	.cards img {
		/* width: 100%;
		height: inherit;*/
		filter: grayscale(100%);
		height: 100%;
		width: 100%;
		object-fit: contain;
		border-radius: 0.8vh;
	}

	.cards p {
		text-align: center;
		line-height: 4vh;
		color: #ededed;
		text-transform: uppercase;
		font-family: 'Poppins', sans-serif;
		font-size: 2vh;
		font-weight: 900;
	}

	.cards:hover {
		box-shadow: inset 0px 4px 4px 3px #000000;
	}
	.cards img:hover {
		/* width: 100%;
		height: inherit;*/
		filter: grayscale(0%);
	}

	p {
		width: 100%;
		height: auto;
		background-color: rgba(23, 23, 23, 0.8);

		padding-bottom: 8%;
	}
	p span {
		font-size: 22px;
		text-align: center;
	}
</style>
