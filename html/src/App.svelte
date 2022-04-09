<script lang="ts">
	import {transition_in} from 'svelte/internal';
	import {slide, fade} from 'svelte/transition';
	import Delete from './lib/Delete.svelte';
	import InfoScreen from './lib/InfoScreen.svelte';
	import RegisterPlayer from './lib/RegisterPlayer.svelte';
	import SelectCharacter from './lib/SelectCharacter.svelte';
	import {fetchNui} from './utils/fetchNui';
	import {isEnvBrowser} from './utils/misc';
	import {useNuiEvent} from './utils/useNuiEvent';
	$: selected = 0;
	let container;
	$: open = isEnvBrowser() ? true : false;
	$: Nchar = [
		{
			id: 1,
			text: 'Empty',
			citizenid: '',
			taked: false,
		},
		{
			id: 2,
			text: 'Empty',
			citizenid: '',
			taked: false,
		},
		{
			id: 3,
			text: 'Empty',
			citizenid: '',
			taked: false,
		},
		{
			id: 4,
			text: 'Empty',
			citizenid: '',
			taked: false,
		},
		{
			id: 5,
			text: 'Empty',
			citizenid: '',
			taked: false,
		},
	];
	$: Data = [];
	let contact = false;
	let welcome = false;
	setTimeout(() => {
		contact = false;
		welcome = true;
	}, 500);
	setTimeout(() => {
		contact = true;
		welcome = false;
		replace();
	}, 2000);
	$: Repl = {
		name: '',
		citizenid: '',
		job: '',
		money: '',
		phone: '',
	};
	useNuiEvent('ui', ({toggle, nChar}) => {
		open = toggle;
		getData();
	});
	function getData() {
		fetchNui('setupCharacters').then((cb) => {
			Data = cb;
			replace();
		});
		fetchNui('removeBlur');
	}
	useNuiEvent('setupCharacters', ({characters}) => {
		Data = characters;
	});

	$: active = false;
	function replace() {
		for (let index = 0; index < Nchar.length; index++) {
			const element = Nchar[index];
			for (let index = 0; index < Data.length; index++) {
				const element1 = Data[index];
				if (element.id === element1.cid) {
					element.taked = true;
					element.text = `${element1.charinfo.firstname} ${element1.charinfo.lastname}`;
					element.citizenid = element1.citizenid;
					Repl.name = `${element1.charinfo.firstname} ${element1.charinfo.lastname}`;
					Repl.citizenid = element1.citizenid;
					Nchar = Nchar;
				}
			}
		}
	}

	$: ss = 0;

	/**
	 * @param {number| string} id
	 */
	function openInfo(id: number | string): InfoScreen {
		let open = true;
		const Info = Data.filter((ids) => ids.citizenid === id);
		Data = Data;
		let m = new InfoScreen({
			target: container,
			props: {
				open: open,
				data: Info,
			},
		});
		return m;
	}
	/**
	 * @param {string | number} citizenid this is the citizenid to spawn the player if taked = true else if the id of the place
	 * @param {boolean} taked Retun false for a empty space, here we can send the modal to create the player
	 */
	function playcreate(citizenid: string | number, taked: boolean) {
		let open1 = true;

		if (taked) {
			fetchNui('selectCharacter', {citizenid: citizenid}).then((cb) => {
				if (cb) {
					open1 = false;
				}
			});
		} else {
			//create new player
			let m = new RegisterPlayer({
				target: container,
				props: {
					open: open1,
					ID: citizenid,
				},
			});
			m.$on('sendRegisterData', (cb) => {
				const data = cb.detail.data;
				fetchNui('createNewCharacter', {firstname: data.firstname, lastname: data.lastname, nationality: data.nationality, birthdate: data.birthdate, gender: data.gender, cid: data.cid});
				open1 = false;
				open = false;
			});

			return m;
		}
	}
	/**
	 * @param {string | number} citizenid
	 * @param {boolean} taked
	 */
	function spawnChar(citizenid: string | number, taked: boolean) {
		if (taked) {
			fetchNui('cDataPed', {citizenid: citizenid, taked: taked});
		} else {
			fetchNui('cDataPed', {citizenid: null, taked: taked});
		}
	}
	function deleteCharacter(citizenid: string) {
		let opens = true;
		let m = new Delete({target: container, props: {open: opens}});
		m.$on('closeModalDelete', (cb) => {
			const data = cb.detail;
			if (data.desicion) {
				opens = false;
				open = false;
				fetchNui('removeCharacter', {citizenid: citizenid});
				resetTable();
			} else {
				opens = false;
			}
		});
	}
	function resetTable() {
		Nchar = Nchar = [
			{
				id: 1,
				text: 'Empty',
				citizenid: '',
				taked: false,
			},
			{
				id: 2,
				text: 'Empty',
				citizenid: '',
				taked: false,
			},
			{
				id: 3,
				text: 'Empty',
				citizenid: '',
				taked: false,
			},
			{
				id: 4,
				text: 'Empty',
				citizenid: '',
				taked: false,
			},
			{
				id: 5,
				text: 'Empty',
				citizenid: '',
				taked: false,
			},
		];
		Nchar = Nchar;
	}
</script>

<svelte:head>
	<link href="https://cdn.jsdelivr.net/npm/quasar@2.6.5/dist/quasar.prod.css" rel="stylesheet" type="text/css" />
</svelte:head>
{#if open}
	<main bind:this={container}>
		<div class="container absolute-center non-selectable">
			{#if welcome}
				<div class="welcomescreen">
					<div class="loading-rondje absolute-center">
						<div class="lds-ring">
							<div />
							<div />
							<div />
							<div />
						</div>
						<p id="loading-text">Loading Characters</p>
					</div>
				</div>
			{/if}
			{#if contact}
				<div class="content" transition:fade style="display:flex;justify-content:space-between;">
					{#each Nchar as char}
						<div class:moveup={ss === char.id ? true : false} on:click|preventDefault={() => (char.taked ? spawnChar(char.citizenid, char.taked) : spawnChar(char.id, char.taked))} class="character-list  flex relative-position q-px-sm q-mx-sm " on:click={() => (ss = char.id)}>
							<span class="absolute-top text-center text-h4">
								{char.text}
							</span>
							<span class="absolute-top text-center text-h6 q-mt-lg q-pt-md">
								{char.citizenid}
							</span>
							{#if ss === char.id ? (active = true) : (active = false)}
								<span transition:slide={{duration: 300}} class="but absolute-center text-center text-h6 q-mt-lg q-pt-md ellipsis" style="left:90%"> <img class="playdelete" on:click={() => (char.taked ? playcreate(char.citizenid, char.taked) : playcreate(char.id, char.taked))} src="https://d29fhpw069ctt2.cloudfront.net/icon/image/38132/preview.svg" alt="name" /> </span>
								{#if char.citizenid.length > 1}
									<span transition:slide={{duration: 300}} on:click|preventDefault={() => (char.taked ? deleteCharacter(char.citizenid) : null)} class="but absolute-center text-center text-h6 q-mt-lg q-pt-md ellipsis" style="left:10%"> <img class="but playdelete" src="https://www.seekpng.com/png/full/202-2022743_edit-delete-icon-png-download-delete-icon-png.png" alt="name" /> </span>

									<span transition:slide={{duration: 300}} on:click={() => openInfo(char.citizenid)} class="but absolute-center text-center text-h6 q-mt-lg q-pt-md ellipsis"> <img class="but playdelete" src="https://img.icons8.com/ios-glyphs/344/info--v3.png" alt="name" /> </span>
								{/if}
							{/if}
						</div>
					{/each}
				</div>
			{/if}
			<div class="infobottom" />
		</div>
	</main>
{/if}

<style>
	@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100&display=swap');
	.container {
		width: 100vw;
		height: 100vh;
	}
	.character-list {
		width: 355px;
		height: 113px;
		background: rgba(23, 23, 23, 0.8);
		overflow: hidden;
		transition: height 0.5s ease-in-out;
	}
	.moveup {
		height: 170px;
		overflow: hidden;
		background: #28a745;
	}
	.character-list:hover {
		border-radius: 0vh 0vh 0.8vh 0.8vh;
		overflow: hidden;
	}
	.character-list:active {
		border-radius: 0vh 0vh 0.8vh 0.8vh;
		overflow: hidden;
	}
	.character-list > span {
		color: #ededed;
		font-weight: 900;
		text-transform: uppercase;
		letter-spacing: 0.1vh;
		font-family: 'Poppins', sans-serif;
	}
	.but {
		width: 32px;
		z-index: 999;
	}
	.but:hover {
		width: 33px;
	}
	.loading-rondje {
		position: absolute;
		margin: 0 auto;
		width: 150px;
		height: 150px;
		transform: translateY(-50%);
		text-align: center;
		padding: 1vh;
	}

	.loading-rondje > p {
		color: white;
		margin-top: 1vh;
		font-family: 'Poppins', sans-serif;
		text-shadow: 1px 1px 0px #00000085;
	}

	.lds-ring {
		display: inline-block;
		position: relative;
		width: 80px;
		height: 80px;
	}

	.lds-ring div {
		box-sizing: border-box;
		display: block;
		position: absolute;
		width: 64px;
		height: 64px;
		border: 8px solid #fff;
		border-radius: 50%;
		animation: lds-ring 1.2s cubic-bezier(0.5, 0, 0.5, 1) infinite;
		border-color: #fff transparent transparent transparent;
	}

	.lds-ring div:nth-child(1) {
		animation-delay: -0.45s;
	}

	.lds-ring div:nth-child(2) {
		animation-delay: -0.3s;
	}

	.lds-ring div:nth-child(3) {
		animation-delay: -0.15s;
	}

	@keyframes lds-ring {
		0% {
			transform: rotate(0deg);
		}
		100% {
			transform: rotate(360deg);
		}
	}
</style>
