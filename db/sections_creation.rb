

puts "Secciones para el curso "+"#{@course_1.name}".green
# Curso 1
# 	Introduccion a ruby							Primer proyecto en ruby
# 	|																|
# 	|- Que es ruby									|- Instalacion de ruby
# 	|																|---- Problemas comunes en windows
# 	|- Ejemplos de codigo en ruby		|---- Problemas comunes en linux
#  																	|- Descargando el editor
# 																	|-----Atom
# 																	|-----Sublime Text
# 																	|-----Notepad++
name = "Introducción de ruby"
father = nil
state = 1
course_id = @course_1.id
url = "http://www.bloggersideas.com/wp-content/uploads/2015/03/Top-10-Programming-Languages.png"
description = '
							'

@s1_co1 = create_section(name,father,state,description,course_id,url)
puts ""

			name = "¿Qué es Ruby?"
			father = @s1_co1.id
			state = 1
			course_id = @course_1.id
			url = "http://www.bloggersideas.com/wp-content/uploads/2015/03/Top-10-Programming-Languages.png"
			description = '	<div>
												<p>
													Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam dolor nisl, rutrum ac leo a, finibus scelerisque purus. In quis ipsum vitae sem egestas vestibulum. Pellentesque augue libero,
													ultrices eu scelerisque vitae, cursus eget tellus. Etiam lacus enim, feugiat eu mauris nec, malesuada pulvinar velit. Integer non elit mauris. Donec aliquet ut libero quis interdum. Vivamus pellentesque
													interdum elementum. Vivamus bibendum at dolor tincidunt elementum. Quisque vel elit vitae elit laoreet euismod. Nunc eu diam id lorem ultrices tincidunt vitae elementum sem. Morbi consequat, nibh quis rutrum
													 vestibulum, nulla nibh laoreet ligula, ullamcorper egestas eros lorem et elit. Morbi efficitur nibh est, eu iaculis dolor varius nec. Nulla quis ullamcorper ante, quis mattis augue. Morbi eu massa id odio blandit
													  commodo. Suspendisse eget tincidunt est, at porttitor dolor. Vestibulum tempus tincidunt quam eget viverra.
												</p>

												<p>
													Phasellus placerat feugiat ultrices. Quisque id enim porttitor, viverra nulla ut, dapibus elit. Fusce sed urna ac
													sapien mollis suscipit. Nam imperdiet diam sit amet diam porttitor, sed consequat orci vulputate. Nam vel dignissim quam.
													 Morbi vel lacus gravida, ullamcorper magna nec, egestas nisi. Nulla lobortis maximus elit quis pellentesque.
												</p>

												<p>
													Aliquam erat volutpat. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.
													 Morbi orci elit, consequat ac nisl id, gravida tempus tellus. Class aptent taciti sociosqu ad litora torquent per conubia nostra,
													 per inceptos himenaeos. Quisque pellentesque venenatis dui, sit amet pretium justo volutpat non. Nunc nisi quam, placerat sodales ex vel,
													 egestas iaculis mauris. In gravida bibendum ullamcorper. Nulla pharetra a odio nec sagittis. Nullam dui tortor, venenatis vitae elementum et, pulvinar non arcu.
												</p>
													<img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_sections/images/section_section_id/image_id/medium/image_name" style="width: 400px;"
												<p>
													Sed eu velit tempus, elementum diam semper, aliquam libero. Nunc sit amet ligula eu mi convallis viverra. Vivamus tempus lorem sed luctus
													 scelerisque. Nullam vel lacinia mauris. Sed consectetur non tortor quis venenatis. Mauris eu lectus auctor, aliquam ligula ac, fermentum dui.
													  Maecenas at risus sapien. In tempor eu metus euismod pulvinar. Aliquam mattis eget libero vel laoreet. Sed pharetra sapien mauris, sed tincidunt
														elit condimentum at. Vestibulum tincidunt felis non risus volutpat tristique. Proin justo turpis, laoreet hendrerit dapibus a, auctor vel erat. Sed semper ac orci eu tempus.
												</p>

												<p>
													Proin sed velit dui. Nullam sed dui ac ex accumsan porttitor. Praesent euismod erat at sem fermentum ullamcorper. Quisque varius tortor justo,
													ut pretium massa volutpat nec. Phasellus consequat elit at enim venenatis pulvinar. Phasellus sem ante, tincidunt vel vestibulum ut, consectetur
													 vestibulum est. Ut a augue nibh. Aenean placerat urna sit amet condimentum consequat. Mauris cursus justo vitae ullamcorper volutpat.
												</p>
											</div>
										'

			@s1_ch1_co1 = create_section(name,father,state,description,course_id,url)
			puts ""

			name = "Ejemplos de codigo en ruby"
			father = @s1_co1.id
			state = 1
			course_id = @course_1.id
			url = "https://discourse-cdn-sjc1.com/business/uploads/github_atom/original/3X/8/b/8b9c0eabe87f2fa7343d5520220ca5527c1d02b5.png"
			description = '

										<div class="code">
											<div class="hl-main">
												<span class="hl-comment">
													=begin
														Esto es
														un comentario
														de varias
														líneas
													=end
													</span>
											</div>
											<p>
												<img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_sections/images/section_section_id/image_id/medium/image_name" style="width: 400px;"

											</p>
										</div>
										'

			@s1_ch2_co1 = create_section(name,father,state,description,course_id,url)



name = "Primer proyecto en ruby"
father = nil
state = 1
course_id = @course_1.id
url = "http://www.bloggersideas.com/wp-content/uploads/2015/03/Top-10-Programming-Languages.png"
description = '
<p>
La mejor forma de usar esta guía es seguir cada paso tal y como se muestra. No hemos ahorrado ninguna línea de código en las explicaciones,
 así que puedes seguirla literalmente paso a paso. Ver el código completo.
Al seguir esta guía, vas a crear un proyecto Rails llamado blog, que es un motor de blogs muy sencillo. Antes de que puedas comenzar a crear la aplicación, asegúrate de tener Rails instalado.
Truco
Los ejemplos que se muestran a continuación usan el carácter $ para representar a la consola de comandos de los sistemas operativos basados en UNIX.
Si estás usando Windows, la línea de comandos se verá como c:\>.
	</p>
							'

@s2_co1 = create_section(name,father,state,description,course_id,url)
puts ""



				name = "Instalación de ruby"
				father = @s2_co1.id
				state = 1
				course_id = @course_1.id
				url = ""
				description = '

											 <p>
											 	Lo primero que debes hacer es abrir una consola de comandos. En Mac OS X eso significa abrir la aplicación Terminal.app. En Windows pincha sobre el menú de inicio y elige la opción Ejecutar y teclea cmd.exe.
													Las líneas que empiezan por $ son los comandos que debes ejecutar en la consola. Lo primero es comprobar que tienes instalada alguna versión reciente de Ruby:
													<p>
													$ ruby -v
													ruby 2.0.0p353
													</p>
													Truco
													Existen varias herramientas para instalar Ruby en tu sistema operativo. Los usuarios de Windows pueden utilizar el instalador de Rails, mientras que los usuarios de Mac OS X pueden usar Tokaido.
													Además, tu sistema debe contar con SQLite 3 instalado correctamente. Para comprobar si es así, ejecuta el siguiente comando:

													<p>
													$ sqlite3 --version
													</p>

													Una vez comprobado que tienes tanto Ruby como SQLite 3, para instalar Rails, usa el comando proporcionado por RubyGems gem install:

													<p>
													$ gem install rails
													</p>

													Para verificar que tu instalación esté correcta, deberías poder ejecutar lo siguiente:
													<p>
													$ rails --version
													</p>


													Si dice algo como "Rails 4.1.1", estás listo para continuar.
											 </p>
											'

				@s2_ch1_co1 = create_section(name,father,state,description,course_id,url)
				puts ""

								name = "Problemas comunes en windows"
								father = @s2_ch1_co1.id
								state = 1
								course_id = @course_1.id
								url = ""
								description = '

															 <p>
															 	Lo primero que debes hacer es abrir una consola de comandos. En Mac OS X eso significa abrir la aplicación Terminal.app. En Windows pincha sobre el menú de inicio y elige la opción Ejecutar y teclea cmd.exe.
																	Las líneas que empiezan por $ son los comandos que debes ejecutar en la consola. Lo primero es comprobar que tienes instalada alguna versión reciente de Ruby:
																	<p>
																	$ ruby -v
																	ruby 2.0.0p353
																	</p>
																	Truco
																	Existen varias herramientas para instalar Ruby en tu sistema operativo. Los usuarios de Windows pueden utilizar el instalador de Rails, mientras que los usuarios de Mac OS X pueden usar Tokaido.
																	Además, tu sistema debe contar con SQLite 3 instalado correctamente. Para comprobar si es así, ejecuta el siguiente comando:

																	<p>
																	$ sqlite3 --version
																	</p>

																	Una vez comprobado que tienes tanto Ruby como SQLite 3, para instalar Rails, usa el comando proporcionado por RubyGems gem install:

																	<p>
																	$ gem install rails
																	</p>

																	Para verificar que tu instalación esté correcta, deberías poder ejecutar lo siguiente:
																	<p>
																	$ rails --version
																	</p>


																	Si dice algo como "Rails 4.1.1", estás listo para continuar.
															 </p>
															'

								@s2_ch1_ch1_co1 = create_section(name,father,state,description,course_id,url)

								name = "Problemas comunes en Linux"
								father = @s2_ch1_co1.id
								state = 1
								course_id = @course_1.id
								url = ""
								description = '

															 <p>
															 	Lo primero que debes hacer es abrir una consola de comandos. En Mac OS X eso significa abrir la aplicación Terminal.app. En Windows pincha sobre el menú de inicio y elige la opción Ejecutar y teclea cmd.exe.
																	Las líneas que empiezan por $ son los comandos que debes ejecutar en la consola. Lo primero es comprobar que tienes instalada alguna versión reciente de Ruby:
																	<p>
																	$ ruby -v
																	ruby 2.0.0p353
																	</p>
																	Truco
																	Existen varias herramientas para instalar Ruby en tu sistema operativo. Los usuarios de Windows pueden utilizar el instalador de Rails, mientras que los usuarios de Mac OS X pueden usar Tokaido.
																	Además, tu sistema debe contar con SQLite 3 instalado correctamente. Para comprobar si es así, ejecuta el siguiente comando:

																	<p>
																	$ sqlite3 --version
																	</p>

																	Una vez comprobado que tienes tanto Ruby como SQLite 3, para instalar Rails, usa el comando proporcionado por RubyGems gem install:

																	<p>
																	$ gem install rails
																	</p>

																	Para verificar que tu instalación esté correcta, deberías poder ejecutar lo siguiente:
																	<p>
																	$ rails --version
																	</p>


																	Si dice algo como "Rails 4.1.1", estás listo para continuar.
															 </p>
															'

								@s2_ch1_ch2_co1 = create_section(name,father,state,description,course_id,url)




				name = "Descargando el editor"
				father = @s2_co1.id
				state = 1
				course_id = @course_1.id
				url = "https://k33.kn3.net/taringa/1/6/4/9/7/4/61/brianbordalejo/B1F.jpg"
				description = '

											 <p>
											 	Lo primero que debes hacer es abrir una consola de comandos. En Mac OS X eso significa abrir la aplicación Terminal.app. En Windows pincha sobre el menú de inicio y elige la opción Ejecutar y teclea cmd.exe.
													Las líneas que empiezan por $ son los comandos que debes ejecutar en la consola. Lo primero es comprobar que tienes instalada alguna versión reciente de Ruby:
													<p>
													$ ruby -v
													ruby 2.0.0p353
													</p>
													Truco
													Existen varias herramientas para instalar Ruby en tu sistema operativo. Los usuarios de Windows pueden utilizar el instalador de Rails, mientras que los usuarios de Mac OS X pueden usar Tokaido.
													Además, tu sistema debe contar con SQLite 3 instalado correctamente. Para comprobar si es así, ejecuta el siguiente comando:

													<p>
													<img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_sections/images/section_section_id/image_id/medium/image_name" style="width: 400px;"

													</p>


													Si dice algo como "Rails 4.1.1", estás listo para continuar.
											 </p>
											'

					@s2_ch2_co1 = create_section(name,father,state,description,course_id,url)
					puts ""

									name = "Atom"
									father = @s2_ch2_co1.id
									state = 1
									course_id = @course_1.id
									url = "https://www.leninalbertop.com.ve/wp-content/uploads/2014/09/atom-text-editor.png"
									description = '

																 <p>
																 	Lo primero que debes hacer es abrir una consola de comandos. En Mac OS X eso significa abrir la aplicación Terminal.app. En Windows pincha sobre el menú de inicio y elige la opción Ejecutar y teclea cmd.exe.
																		Las líneas que empiezan por $ son los comandos que debes ejecutar en la consola. Lo primero es comprobar que tienes instalada alguna versión reciente de Ruby:
																		<p>
																		$ ruby -v
																		ruby 2.0.0p353
																		</p>
																		Truco
																		Existen varias herramientas para instalar Ruby en tu sistema operativo. Los usuarios de Windows pueden utilizar el instalador de Rails, mientras que los usuarios de Mac OS X pueden usar Tokaido.
																		Además, tu sistema debe contar con SQLite 3 instalado correctamente. Para comprobar si es así, ejecuta el siguiente comando:

																		<p>
																		<img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_sections/images/section_section_id/image_id/medium/image_name" style="width: 400px;"

																		</p>


																		Si dice algo como "Rails 4.1.1", estás listo para continuar.
																 </p>
																'

										@s2_ch2_ch1_co1 = create_section(name,father,state,description,course_id,url)
										puts ""

										name = "Sublime text"
										father = @s2_ch2_co1.id
										state = 1
										course_id = @course_1.id
										url = "http://gestionportalescomercio.com/wp-content/uploads/2015/04/Sublime_Text_Logo.png"
										description = '

																	 <p>
																	 	Lo primero que debes hacer es abrir una consola de comandos. En Mac OS X eso significa abrir la aplicación Terminal.app. En Windows pincha sobre el menú de inicio y elige la opción Ejecutar y teclea cmd.exe.
																			Las líneas que empiezan por $ son los comandos que debes ejecutar en la consola. Lo primero es comprobar que tienes instalada alguna versión reciente de Ruby:
																			<p>
																			$ ruby -v
																			ruby 2.0.0p353
																			</p>
																			Truco
																			Existen varias herramientas para instalar Ruby en tu sistema operativo. Los usuarios de Windows pueden utilizar el instalador de Rails, mientras que los usuarios de Mac OS X pueden usar Tokaido.
																			Además, tu sistema debe contar con SQLite 3 instalado correctamente. Para comprobar si es así, ejecuta el siguiente comando:

																			<p>
																			<img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_sections/images/section_section_id/image_id/medium/image_name" style="width: 400px;"

																			</p>


																			Si dice algo como "Rails 4.1.1", estás listo para continuar.
																	 </p>
																	'

											@s2_ch2_ch2_co1 = create_section(name,father,state,description,course_id,url)
											puts ""

											name = "Notepad++"
											father = @s2_ch2_co1.id
											state = 1
											course_id = @course_1.id
											url = "https://2.bp.blogspot.com/-6pZzTdt2_BE/ViF7XkcyjnI/AAAAAAAAATo/ceEWYRM4Jd0/s1600/Notepad%252B%252B.png"
											description = '

																		 <p>
																		 	Lo primero que debes hacer es abrir una consola de comandos. En Mac OS X eso significa abrir la aplicación Terminal.app. En Windows pincha sobre el menú de inicio y elige la opción Ejecutar y teclea cmd.exe.
																				Las líneas que empiezan por $ son los comandos que debes ejecutar en la consola. Lo primero es comprobar que tienes instalada alguna versión reciente de Ruby:
																				<p>
																				$ ruby -v
																				ruby 2.0.0p353
																				</p>
																				Truco
																				Existen varias herramientas para instalar Ruby en tu sistema operativo. Los usuarios de Windows pueden utilizar el instalador de Rails, mientras que los usuarios de Mac OS X pueden usar Tokaido.
																				Además, tu sistema debe contar con SQLite 3 instalado correctamente. Para comprobar si es así, ejecuta el siguiente comando:

																				<p>
																				<img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_sections/images/section_section_id/image_id/medium/image_name" style="width: 400px;"

																				</p>


																				Si dice algo como "Rails 4.1.1", estás listo para continuar.
																		 </p>
																		'

											@s2_ch2_ch3_co1 = create_section(name,father,state,description,course_id,url)
											puts ""

				name = "Iniciando en la consola"
				father = @s2_co1.id
				state = 1
				course_id = @course_1.id
				url = ""
				description = '

											 <p>
											 	Lo primero que debes hacer es abrir una consola de comandos. En Mac OS X eso significa abrir la aplicación Terminal.app. En Windows pincha sobre el menú de inicio y elige la opción Ejecutar y teclea cmd.exe.
													Las líneas que empiezan por $ son los comandos que debes ejecutar en la consola. Lo primero es comprobar que tienes instalada alguna versión reciente de Ruby:
													<p>
													$ ruby -v
													ruby 2.0.0p353
													</p>
													Truco
													Existen varias herramientas para instalar Ruby en tu sistema operativo. Los usuarios de Windows pueden utilizar el instalador de Rails, mientras que los usuarios de Mac OS X pueden usar Tokaido.
													Además, tu sistema debe contar con SQLite 3 instalado correctamente. Para comprobar si es así, ejecuta el siguiente comando:

													<p>
													$ sqlite3 --version
													</p>

													Una vez comprobado que tienes tanto Ruby como SQLite 3, para instalar Rails, usa el comando proporcionado por RubyGems gem install:

													<p>
													$ gem install rails
													</p>

													Para verificar que tu instalación esté correcta, deberías poder ejecutar lo siguiente:
													<p>
													$ rails --version
													</p>


													Si dice algo como "Rails 4.1.1", estás listo para continuar.
											 </p>
											'

					@s2_ch3_co1 = create_section(name,father,state,description,course_id,url)
					puts ""
