<script lang="ts">
	import Proflist from '../assets/proflist';
	import SelectCharacter from './SelectCharacter.svelte';
	import {fade, fly} from 'svelte/transition';
	import {createEventDispatcher} from 'svelte';
	import Modal from './Modal.svelte';

	let container;

	export let open = false;
	const dispatch = createEventDispatcher();
	const regTest = new RegExp(Proflist.join('|'), 'i');
	$: data = {
		name: '',
		lastName: '',
		nationality: '',
		date: '',
		gender: 'Male',
		reset: () => {
			this.name = '';
			this.lastName = '';
			this.nationality = '';
			this.gender = 'Male';
		},
	};

	$: check = data.name.length < 4 || data.lastName.length < 4 || data.nationality.length < 4 || data.date === '';
	$: ter = data.name.length < 4 ? 'The Name is too short' : data.lastName.length < 4 ? 'The Last name is too short' : data.nationality.length < 4 ? 'the nationality is too short' : data.date === '' ? 'Select a propper Date' : null;
	function sendData() {
		let open = true;
		if (check || regTest.test(data.name) || regTest.test(data.lastName)) {
			let m = new Modal({
				target: container,
				props: {
					open: open,
					message: `${check ? ter : regTest.test(data.name) ? `A bad word is present on the Name, Word "${data.name}"` : regTest.test(data.lastName) ? `A bad word is present on the Name, Word "${data.lastName}"` : ''}`,
				},
			});
			m.$on('Close', () => (open = false));
		} else {
			let m = new SelectCharacter({
				target: container,
				props: {
					open: open,
				},
			});
			return m;
		}

		// open = false;
		// dispatch('sendRegisterData', {data});
	}
	function closeModal() {
		open = false;
		dispatch('closeModal', {});
	}
</script>

{#if open}
	<div bind:this={container} in:fade={{delay: 600}} out:fade>
		<div class="container fit non-selectable">
			<div class="my-back">
				<div class="modal-overlay ">
					<div class="character-register absolute-center">
						<div class="closebutton absolute-right" on:click={closeModal}>
							<p class="absolute-center">Close</p>
						</div>
						<div class="characters-register-block-header">
							<p>Character Registration</p>
						</div>

						<div class="char-register-inputs">
							<input bind:value={data.name} type="text" name="" id="firstName" class="char-reg-input text-capitalize" />
							<input bind:value={data.lastName} type="text" name="" id="lastName" class="char-reg-input text-capitalize" />
							<input bind:value={data.nationality} type="text" name="flag" id="nationality" class="char-reg-input text-capitalize" />

							<select bind:value={data.gender} id="gender" name="gender">
								<option value="Male" selected>Man</option>
								<option value="Female">Woman</option>
							</select>
							<input bind:value={data.date} type="date" name="" id="birthdate" min="1900-01-01" max="2999-12-31" class="char-reg-input " />
						</div>
						<div on:click|preventDefault={sendData} class="character-reg-btn">
							<p>Register</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
{/if}

<style>
	.closebutton {
		margin-top: 25px;
		margin-right: 7.5%;
		z-index: 999;
		width: 12.5%;
		height: 8%;
		color: #ededed;
		background-color: #dc143c;
		font-size: 1.3vh;
		font-weight: 900;
		border-radius: 0.3vh;
		cursor: pointer;
		padding: 0.3vh;
	}
	.character-register {
		width: 25%;
		height: 38%;
		margin-left: auto;
		margin-right: auto;
		background-color: rgb(23 23 23 / 80%);
		border-radius: 0.8vh;
		padding: 30px;
		font-family: 'Poppins', sans-serif;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}

	.characters-register-block-header {
		text-transform: uppercase;
		position: absolute;
		width: 100%;
		height: 12vh;
		color: #ededed;
		text-align: left;
		font-size: 2vh;
		font-weight: 900;
	}

	.char-register-inputs {
		position: absolute;
		top: 14%;
		overflow: visible !important;
	}

	.char-reg-input {
		position: relative;
		float: left;
		margin-top: 1vh;
		border: none;
		background-color: #444444;
		outline: none;
		width: 92%;
		height: 3vh;
		color: #ededed;
		max-width: 100%;
		font-weight: 900;
		padding: 4px;
		border-radius: 0.3vh;
		font-family: 'Poppins', sans-serif;
		text-align: center;
		transition: all 0.2s ease-in-out;
		cursor: text;
	}

	select {
		position: absolute;
		border: none;
		border: 0.3vh solid #444444;
		background-color: #171717;
		outline: none;
		width: 93.5%;
		height: 4vh;
		top: 19.9vh;
		left: 0.1vh;
		color: #ededed;
		max-width: 100%;
		padding: 4px;
		border-radius: 0.3vh;
		font-family: 'Poppins', sans-serif;
		text-align-last: center;
		-webkit-appearance: none;
		-moz-appearance: none;
		text-indent: 1px;
		text-overflow: '';
		transition: all 0.2s ease-in-out;
		cursor: pointer;
	}

	select:hover {
		background-color: rgba(34, 34, 34, 0.808);
	}

	select:focus {
		background-color: rgba(34, 34, 34, 0.808);
	}

	#gender option {
		background-color: transparent;
		border: none;
		outline: none;
	}

	select::placeholder {
		text-align: center;
	}

	select::-ms-expand {
		display: none;
	}

	.char-reg-input::placeholder {
		color: rgba(255, 255, 255, 0.52);
	}

	input[type='date'] {
		color: #ededed;
		text-align: center;
	}

	input[type='date']::-webkit-calendar-picker-indicator {
		display: none;
	}

	input[type='date']::-webkit-inner-spin-button,
	input[type='date']::-webkit-outer-spin-button {
		-webkit-appearance: none;
		margin: 0;
	}

	input[type='date']::-webkit-input-placeholder {
		visibility: hidden !important;
	}

	input[type='date']::-webkit-clear-button {
		display: none;
	}

	#birthdate {
		color: #ededed;
		text-align: center;
		font-family: 'Poppins', sans-serif;
	}

	.character-reg-btn {
		position: absolute;
		max-width: 87%;
		height: 4vh;
		background-color: #dc143c;
		border-radius: 0.3vh;
		bottom: 3vh;
		margin: 0 auto;
		left: 0;
		right: 0;
		cursor: pointer;
	}

	.character-reg-btn > p {
		text-align: center;
		line-height: 4vh;
		color: #ededed;
		text-transform: uppercase;
		font-family: 'Poppins', sans-serif;
		font-size: 2vh;
		font-weight: 900;
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
</style>
