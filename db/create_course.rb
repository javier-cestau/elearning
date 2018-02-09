                    #------------------------------- Curso 1



                    name_course = "Aprenda a Programar con ruby parte 1"
                    scoping = 1
                    prelation = 0
                    category_id = @categories_id.at(1).id #Tecnologia
                    active = 0
                    start_date = Date.today.to_s
                    deadline_inscription = Date.today.to_s
                    deadline_course = Date.today.to_s
                    url_cover = "https://www.sitepoint.com/wp-content/themes/sitepoint/assets/images/icon.ruby.png"
                    url = "https://historiadelarteen.files.wordpress.com/2012/02/slide4.jpg"
                    description = '<p>
                                  <span style="font-size: 24px;">Aprender a programar es un objetivo que se plantea mucha gente y que no todos alcanzan. Hay que tener claro que aprender programación no es tarea de un día ni de una semana: aprender programación requiere al menos varios meses y, si hablamos de programación a nivel profesional, varios años. No queremos con esto desanimar a nadie: en un plazo de unos pocos días podemos estar haciendo nuestros primeros programas y ver los primeros resultados, pero aprender a programar es mucho más que eso. Vamos a tratar de exponer nuestra visión sobre una forma adecuada de enfrentarnos al aprendizaje de la programación.
                                  </span>
                                </p>
                                <p style="">
                                  <span style="font-size: 24px;">&nbsp;
                                  </span>&nbsp;
                                </p>
                                  <p>
                                  <br>
                                </p>
                                <img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_courses/images/course_course_id/image_id/medium/image_name" style="width: 400px;"
                                <p>
                                  <span style="font-size: 24px;">En primer lugar diremos que “aprender a programar” es una expresión
                                   bastante indefinida. Existen cientos de lenguajes de programación y de variantes, versiones, modificaciones, etc. así como distintos enfoques en cuanto a los objetivos (programación web, aplicaciones de gestión,
                                    aplicaciones de bases de datos, etc.). Por tanto “aprender a programar” es bastante ambiguo: es como decir “quiero aprender a pintar”. Nos permitiría centrarnos mejor definir un objetivo más específico: “Quiero aprender a dibujar comics estilo manga”.
                                  </span>
                                </p>
                                <p>
                                  <span style="font-size: 24px;">El problema para los no iniciados es muchas veces que la programación es un campo muy cambiante, donde hay una continua
                                   proliferación de versiones y pugnas entre casas comerciales que hacen que los lenguajes cambien muy rápidamente y nadie sepa muy bien qué es lo más conveniente aprender.
                                  </span>
                                </p>
                                <p>
                                  <span style="font-size: 24px;">Frente a esta situación, y para todos aquellos que quieren empezar a programar, sabiendo o no hacia qué lenguaje se van
                                  a orientar, nuestra propuesta es que usen aprenderaprogramar.com como sitio de referencia a través del cual poder dar los primeros pasos en programación. Una vez adquiridos los fundamentos y sentadas las bases, será más fácil buscar información y elegir entre las distintas plataformas y lenguajes existentes.
                                  </span>
                                </p>
                                <p>
                                  <span style="font-size: 24px;">Vamos a reflexionar sobre lo que consideramos son opciones adecuadas y opciones no adecuadas para las personas que
                                  quieren aprender a programar sin tener conocimientos previos, o con unos conocimientos previos muy limitados.
                                  </span>
                                </p>
                                <ul>
                                  <li>
                                    <span style="font-size: 24px;">a) &nbsp; <strong>Aprender con un libro ó con apuntes de forma autodidacta:</strong> no es una mala opción para
                                    personas que quieran aprender por libre, siempre que se encuentre un buen libro y se tenga voluntad, base lógico-matemática y determinación para estudiar por cuenta propia durante un periodo de tiempo prolongado. En cualquier caso el libro debe tratar sobre
                                    fundamentos de la programación, con aplicación (para ver el lado práctico) a algún lenguaje. Si estás interesado en esta vía, te recomendamos visitar la sección “Libros” de aprenderaprogramar.com y ver los libros disponibles sobre fundamentos de programación.</span>
                                  </li>

                                </ul>
                                <h2>
                                  <span style="font-size: 24px;">&nbsp;</span>
                                </h2>
                                <p style="font-size: 25px;"><br>
                                  </p>
                                <p>&nbsp;</p>;'



                  @course_1 = create_course(name_course,scoping,prelation,active,category_id,start_date,deadline_course,deadline_inscription,description,url,url_cover)

                  create_tag(["ruby","programacion"],@course_1)





                  #------------------------------- Curso 2


                  name_course = "Aprenda a Programar con ruby Parte 2"
                  scoping = 2
                  prelation = 1
                  category_id = @categories_id.at(1).id #Tecnologia
                  active = 0
                  start_date = "2018-11-09"
                  deadline_inscription = "2018-11-05"
                  deadline_course = "2018-12-09"
                  description = '<div class="no-overflow" id="yui_3_17_2_1_1505393027078_145">'+
                  '   <h1 style="text-align: center;"><span style="color: #4169e1;">.:</span>&nbsp;Programación Avanzada</h1>'+
                  '   <p><span style="font-size: small; font-family: Verdana;">&nbsp;</span></p>'+
                  '   <p id="yui_3_17_2_1_1505393027078_144"><span style="font-size: small; font-family: Verdana;" id="yui_3_17_2_1_1505393027078_143">El objetivo de la asignatura es introducir elementos necesarios para la construcción de sistemas de software de mediano y gran porte, aplicando para ello el paradigma de desarrollo denominado orientación a objetos.<br> Particularmente, la asignatura se enfocará en:</span></p>'+
                  '   <ul>'+
                  '      <li><span style="font-size: small;"><span style="font-family: Verdana;"></span>Dar a conocer herramientas para el análisis y diseño de sistemas orientados a objetos basadas en el lenguaje de modelado UML</span></li>'+
                  '   </ul>'+
                  '   <ul>'+
                  '      <li><span style="font-size: small;">Presentar una metodología básica para el uso de dichas herramientas</span></li>'+
                  '   </ul>'+
                  '   <ul>'+
                  '      <li><span style="font-size: small;">Dominar las construcciones de la orientación a objetos en el lenguaje C++</span></li>'+
                  '   </ul>'+
                  '   <ul>'+
                  '      <li><span style="font-size: small;">Adquirir experiencia en el desarrollo de un sistema completamente funcional</span></li>'+
                  '   </ul>'+
                  '   <h2 id="yui_3_5_1_1_1362315644002_1728" style="text-align: justify;"><span id="yui_3_5_1_1_1362315644002_1727" style="color: #4169e1;">.:</span>&nbsp;Varios</h2>'+
                  '   <p><strong>_______________________________________________________________________</strong></p>'+
                  '</div>'
                  url_cover = "http://programacion.net/files/article/20151023121029_rubyrails.png"
                  url = ""

                  @course_2 = create_course(name_course,scoping,prelation,active,category_id, start_date,deadline_course,deadline_inscription,description,url,url_cover)

                  create_tag(["ruby","programacion","rails"],@course_2)

                  departments = Array.new

                  departments.push(@department.at(0))
                  departments.push(@department.at(1))
                  departments.push(@department.at(5))
                  departments.push(@department.at(3))
                  departments.push(@department.at(4))

                  create_relation_department_course(@course_2,departments)



                  #------------------------------- Curso 3

                name_course = "Historia del arte"
                scoping = 3
                prelation = 1
                category_id = @categories_id.at(0).id #Arte
                active = 1
                start_date = "2018-04-09"
                deadline_inscription = "2018-08-05"
                deadline_course = "2018-12-30"
                description = ' <h1><span style="color:#ffcc00;">Que&nbsp;estudia&nbsp;la Historia del Arte?</span></h1>
                                <h3>
                                  <span style="color:#ffcc99;"><em><strong>L</strong></em></span>
                                  <strong><span style="color:#ffcc99;"><em>a Historia del Arte</em></span>
                                   es una disciplina de las ciencias sociales que estudia la evolución del arte a través del tiempo y basa sus estudios en el análisis de las expresiones artísticas del hombre y como este ha representado su visión&nbsp; particular del mundo que
                                   lo rodea a través de las distintas técnicas y manifestaciones artísticas en cada uno de los periodos históricos.</strong>
                                </h3>
                                <h3>
                                  La Historia del arte se apoya en otras disciplinas complementarias como la&nbsp;Arqueología, la Antropología, la&nbsp;geología&nbsp;y la Historia entre otras ciencias para&nbsp;corroborar con&nbsp;más&nbsp;acierto los datos que recopila; a partir
                                  de los&nbsp;restos mobiliarios e inmobiliarios dejados por el hombre y con los que este&nbsp;representó&nbsp;la&nbsp;necesidad de expresión visual de su entorno e historia; ya fuera con intención decorativa,
                                  funcional &nbsp;o&nbsp;también&nbsp;utilizada como propaganda o&nbsp;adoración&nbsp;religiosa, así como&nbsp;&nbsp;llevado&nbsp;también por la necesidad de perpetuar la historia de su civilización dejando la huella de su existencia.
                                </h3>
                              '
                url_cover = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Mona_Lisa_detail_face.jpg/220px-Mona_Lisa_detail_face.jpg"
                url = ""

                @course_3 = create_course(name_course, scoping, prelation, active, category_id, start_date, deadline_course, deadline_inscription, description,url,url_cover)

                create_tag(["arte","historia","leiros","parte 1"],@course_3)

                create_relation_private_course(@course_3,@admin)
                create_relation_private_course(@course_3,@medium_user)




                #------------------------------- Curso 4

                name_course = "Matematicas Básicas"
                scoping = 1
                prelation = 0
                category_id = @categories_id.at(2).id #Logica
                active = 1
                start_date = Date.today
                deadline_inscription = "2018-10-05"
                deadline_course = "2018-11-09"
                description = ' <div id="centerColumnPrincipal">
                                  <h2>Presentación</h2>
                                  <ul>
                                    <p> La asignatura Matemáticas Básicas forma parte de los tres grados aprobados por la Facultad de Matemáticas de la Universidad Complutense de Madrid: Grado en Matemáticas, Grado en Ingeniería Matemática y Grado en Matemáticas y Estadística. Esta asignatura se imparte al inicio del primero de los dos cursos comunes a los tres grados ofertados por la Facultad de Matemáticas de la Universidad Complutense de Madrid.</p>

                                    <p></p><center> <a href="">Enlace a la ficha de la asignatura</a></center><p></p>

                                    <p> La asignatura Matemáticas Básicas tiene carácter introductorio y transversal, y está dirigida a los estudiantes que comienzan estudios de Matemáticas. El objetivo inicial de esta asignatura es conseguir que los estudiantes de primer curso se hagan con los procedimientos prácticos básicos que permiten su adaptación al estudio de las matemáticas en la Universidad. Se pretende que, al finalizar la asignatura, los estudiantes sean capaces de abordar de manera eficaz el trabajo matemático.</p>

                                    <p> En concreto se busca que los alumnos que cursan esta asignatura adquieran las siguientes competencias:</p>
                                    <p>
                                    </p><li>Conocer el lenguaje matemático y las diferencias con el lenguaje habitual.</li>
                                    <li>Conocer las técnicas de demostración básicas en Matemáticas. Utilizar la visualización para desarrollar una primera intuición sobre los problemas y su resolución.</li>
                                    <li>Aplicar los conocimientos previamente citados en problemas concretos de Aritmética, Geometría, Álgebra y Análisis Matemático.</li>
                                    <li>Desarrollar la capacidad para identificar datos relevantes de un problema, estructurar la información disponible y elaborar una estrategia de resolución.</li>
                                    <li>Expresar de modo correcto los argumentos que articulan la solución de un problema.</li><p></p>
                                    <li>
                                      <img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_courses/images/course_course_id/image_id/medium/image_name" style="width: 400px;"

                                    </li><p></p>

                                    <p> La asignatura será impartida por profesorado adscrito a cuatro programas distintos: programa de Álgebra, programa de Análisis Matemático, programa de Geometría y Topología y programa de Matemática Aplicada. Está estructurada en sesiones intensivas diarias.</p>

                                  </ul>
                                </div>
                                      '
                url_cover = "http://icdn.pro/images/es/l/a/la-educacion-matematica-icono-6956-128.png"
                url = "http://4.bp.blogspot.com/-QKuZd2W4RAo/U2GrNy3OEhI/AAAAAAAAABw/h0qxdC4jBoA/s1600/descarga.jpg"

                @course_4 = create_course(name_course, scoping, prelation, active, category_id, start_date, deadline_course, deadline_inscription, description,url,url_cover)

                create_tag(["mate","matematica","sumas","restas"],@course_4)



                  #------------------------------- Curso 5

                name_course = "Lógica de programación"
                scoping = 2
                prelation = 0
                category_id = @categories_id.at(2).id #Logica
                active = 1
                start_date = Date.today
                deadline_inscription = ""
                deadline_course = ""

                description = ' <div id="centerColumnPrincipal">
                                  <h2>Presentación</h2>
                                  <ul>
                                    <p> La asignatura Matemáticas Básicas forma parte de los tres grados aprobados por la Facultad de Matemáticas de la Universidad Complutense de Madrid: Grado en Matemáticas, Grado en Ingeniería Matemática y Grado en Matemáticas y Estadística. Esta asignatura se imparte al inicio del primero de los dos cursos comunes a los tres grados ofertados por la Facultad de Matemáticas de la Universidad Complutense de Madrid.</p>

                                    <p></p><center> <a href="">Enlace a la ficha de la asignatura</a></center><p></p>

                                    <p> La asignatura Matemáticas Básicas tiene carácter introductorio y transversal, y está dirigida a los estudiantes que comienzan estudios de Matemáticas. El objetivo inicial de esta asignatura es conseguir que los estudiantes de primer curso se hagan con los procedimientos prácticos básicos que permiten su adaptación al estudio de las matemáticas en la Universidad. Se pretende que, al finalizar la asignatura, los estudiantes sean capaces de abordar de manera eficaz el trabajo matemático.</p>

                                    <p> En concreto se busca que los alumnos que cursan esta asignatura adquieran las siguientes competencias:</p>
                                    <p>
                                    </p><li>Conocer el lenguaje matemático y las diferencias con el lenguaje habitual.</li>
                                    <li>Conocer las técnicas de demostración básicas en Matemáticas. Utilizar la visualización para desarrollar una primera intuición sobre los problemas y su resolución.</li>
                                    <li>Aplicar los conocimientos previamente citados en problemas concretos de Aritmética, Geometría, Álgebra y Análisis Matemático.</li>
                                    <li>Desarrollar la capacidad para identificar datos relevantes de un problema, estructurar la información disponible y elaborar una estrategia de resolución.</li>
                                    <li>Expresar de modo correcto los argumentos que articulan la solución de un problema.</li><p></p>
                                    <li>
                                      <img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_courses/images/course_course_id/image_id/medium/image_name" style="width: 400px;"

                                    </li><p></p>

                                    <p> La asignatura será impartida por profesorado adscrito a cuatro programas distintos: programa de Álgebra, programa de Análisis Matemático, programa de Geometría y Topología y programa de Matemática Aplicada. Está estructurada en sesiones intensivas diarias.</p>

                                  </ul>
                                </div>
                                      '
                url_cover = "https://userscontent2.emaze.com/images/6b65efa2-5db8-4bf5-b81e-43495034c12a/876f04f3-cfd2-4997-ae9d-3862c08bc84b.jpg"
                url = "https://dev-res.thumbr.io/libraries/82/12/41/lib/1451079572633_1.jpg?size=854x493s&ext=jpg"

                @course_5 = create_course(name_course, scoping, prelation, active, category_id, start_date, deadline_course, deadline_inscription, description,url,url_cover)


                  create_tag(["programacion","diagramas de flujo","logica","principiantes"],@course_5)

                  departments = Array.new
                  departments.push(@department.at(2))
                  departments.push(@department.at(1))
                  departments.push(@department.at(0))
                  departments.push(@department.at(5))

                  create_relation_department_course(@course_5,departments)



                  #------------------------------- Curso 6



                  name_course = "Derecho penal"
                  scoping = 1
                  prelation = 0
                  category_id = @categories_id.at(3).id #Derecho
                  active = 1
                  start_date = Date.today
                  deadline_inscription = ""
                  deadline_course = ""

                  url_cover = "https://i1.wp.com/parsippanyfocus.com/wp-content/uploads/2016/01/handcuffs.jpg?resize=696%2C461"
                  url = "https://www.definicionabc.com/wp-content/uploads/2015/04/Derecho-Penal.jpg"
                  description = '<section>
                    								<p>El <a href="http://conceptodefinicion.de/derecho/">Derecho</a> Penal <strong>es la importante rama del derecho encargada de establecer todo un compendio de penas y castigos para imponerlos a quien haya cometido un delito</strong>,
                                       el cual amerite una condena por los actos cometidos. El Derecho Penal <strong>comprende una serie de leyes jurídicas</strong> con poder para privar de libertades y velar por el cumplimiento de las <strong>sanciones impuestas</strong>.
                                       El Derecho Penal dicta todo tipo de <a href="http://conceptodefinicion.de/sentencia/">sentencia</a> ante situaciones que puedan alterar de manera negativa el orden de <strong>la vida en la sociedad</strong>
                                      , si una persona infringe en <strong>el código civil</strong> y viola los estatutos morales impuestos por <strong>la ética y la moral del <a href="http://conceptodefinicion.de/medio-ambiente/">medio ambiente</a> que lo rodea</strong>,
                                      se vera obligado a pagar por sus <a href="https://www.infraccionesba.net/webInfractor.do;jsessionid=bXQdzaamqicLjy-YbpZarID2.undefined?method=precargarBusqueda" target="_blank" class="broken_link">infracciones</a>.</p>
                                      <p>
                                        <img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_courses/images/course_course_id/image_id/medium/image_name" style="width: 400px;"
                                      </p>
                                      <p>Las leyes de las que el derecho penal dispone <strong>son creadas y adaptadas de acuerdo a la violación a los derechos y deberes de la sociedad cometidos</strong>, por esto, el derecho penal supone todo un complejo proceso en el que
                                      se analizan las razones por las cuales se ejecuta una acción y el por que debe ser juzgado de manera categórica, impulsando de esta manera ejemplos clásicos de reprendimiento para toda la ciudadanía. <strong>En la antiguedad, ante la ausencia de
                                       conocimientos y practicas en relación a los <a href="http://www.who.int/topics/human_rights/es/" target="_blank">derechos humanos</a> y organizaciones que los defendieran</strong>, los castigos y penas eras drásticas y rudas, al <a href="http://conceptodefinicion.de/punto/">punto</a>
                                       de llegar a extremos de quitarle la vida a las personas o amputarles partes del cuerpo como medida de pago; hoy en día, la relación entre el delito y la pena es humana, pero sin dejar claro la severidad del asunto y el porqué de la pena.</p>
                                      <p><strong>El objetivo clave del derecho penal es proteger a la sociedad de las malas costumbres</strong>, fue ideado con el precepto de dejar en claro que el estado y las instituciones deben permanecer firmes a la corrupción y la maldad, fundando así sentimientos de libertad y buen vivir entre los ciudadanos.
                                       El derecho penal, por ser el área del <a href="http://www.mendezabogados.com/campjurid.htm" target="_blank">campo jurídico</a> encargado de imponer castigos y sanciones, fácilmente se relaciona con las demás áreas del derecho, ya que todas presentan situaciones en la que la falta de principios puede acarrear síntomas negativos
                                       a la vida común, <strong>sirviéndose del derecho penal como herramienta para elaborar sanciones en torno a las faltas dentro de las áreas correspondientes</strong>.</p><p></p>
                                  </section>'



                @course_6 = create_course(name_course,scoping,prelation,active,category_id, start_date,deadline_course,deadline_inscription,description,url,url_cover)

                create_tag(["penal","sentencia","esclavo","muerte","derecho","nepe"],@course_6)


                  #------------------------------- Curso 7

                  name_course = "Derecho tributario I"
                  scoping = 1
                  prelation = 0
                  category_id = @categories_id.at(3).id #Derecho
                  active = 1
                  start_date = Date.today - 5.days
                  deadline_inscription = ""
                  deadline_course = Date.today - 5.days
                  url_cover = "http://conceptodefinicion.de/wp-content/uploads/2012/11/DerechoTributario.jpg"
                  url = "https://www.definicionabc.com/wp-content/uploads/2013/05/Derecho-Tributario.jpg"
                  description = '<div class="analisis">
                                  <p>
                                    <img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_courses/images/course_course_id/image_id/medium/image_name" style="width: 400px;"

                                  El<strong> <a title="Derecho" href="https://www.definicionabc.com/derecho/derecho.php">Derecho</a> Tributario</strong>, también denominado como concepto de <strong><a title="Derecho Fiscal" href="https://www.definicionabc.com/derecho/derecho-fiscal.php">Derecho Fiscal</a></strong>, es parte integrante del <strong>
                                  <a title="Derecho Público" href="https://www.definicionabc.com/derecho/derecho-publico.php">Derecho Público</a></strong>, el cual a su vez está inserto dentro del <strong><a title="Derecho Financiero" href="https://www.definicionabc.com/derecho/derecho-financiero.php">Derecho Financiero</a></strong>,
                                  y se ocupa de <strong>estudiar las leyes a partir de las cuales el gobierno local manifiesta su fuerza tributaria con la misión de conseguir a través del mismo <a title="ingresos" href="https://www.definicionabc.com/economia/ingresos.php">ingresos</a> económicos por parte de los ciudadanos y empresas, y que son los que le
                                   permitirán cubrir el gasto público de todas las áreas del estado</strong>.</p>
                                  <p>O sea, que a través de los llamados <strong>impuestos</strong>, que son obligaciones monetarias sostenidas por <a title="ley" href="https://www.definicionabc.com/derecho/ley.php">ley</a>, el estado se hace de dinero para sostener y mantener las diferentes áreas que componen el estado: <a title="administración pública" href="https://www.definicionabc.com/politica/administracion-publica.php">
                                  administración pública</a>, y por otra parte garantiza a los ciudadanos la <strong>satisfacción y el acceso a servicios tales como: seguridad, salud, <a title="educación" href="https://www.definicionabc.com/general/educacion.php">educación</a></strong>, entre los principales. </p><div class="pub_adsense_2central">
                                  <p>Mientras tanto, serán los contribuyentes, ciudadanos o personas jurídicas, quienes deberán cumplir con el pago de esos tributos que fija la ley nacional.</p>
                                  <p>El pago de un impuesto no implicará, para quien paga, una contraprestación de efecto inmediato de parte del estado, pero lo que si le garantizará es que la persona podrá acceder a la educación y salud públicas y asimismo gozará de la protección que le brindan las fuerzas de seguridad nacionales, justamente sostenidas económicamente a través de los impuestos que impone el estado.</p>
                                  <p>Nos podremos encontrar con diferentes tipos de impuestos:<strong> internos </strong>(se reúnen en la nación en cuestión, en las provincias, municipios, ciudades, tal es el caso del Impuesto al Valor Agregado (IVA), Ingresos Brutos, Impuesto sobre la renta, entre otros),<strong> externos </strong>(son el resultado de la <a title="importación" href="https://www.definicionabc.com/economia/importacion.php">importación</a>
                                  , es decir, del ingreso a un país de bienes y servicios), <strong>directos</strong> (porque se aplican de modo directo repercutiendo en los ingresos o las propiedades), <strong>indirectos</strong> (alcanzan a personas ajenas al contribuyente, es decir, el impuesto lo abona quien recibe o compra bienes),<strong> reales y objetivos </strong>(gravan a las personas sin tener en cuenta las condiciones personales), <strong>
                                  personales o subjetivos </strong>(tienen en especial cuenta la capacidad contributiva de los individuos, tomándose en consideración los ingresos que perciben y el patrimonio que disponen).</p>
                                  <div class="clear">&nbsp;</div>
                      			</div>'


                @course_7 = create_course(name_course,scoping,prelation,active,category_id, start_date,deadline_course,deadline_inscription,description,url,url_cover)

                create_tag(["tributario","parte 1","derecho"],@course_7)




                  #------------------------------- Curso 8

                  name_course = "Derecho tributario II"
                  scoping = 1
                  prelation = 0
                  category_id = @categories_id.at(3).id #Derecho
                  active = 0
                  start_date = "2017-09-01"
                  deadline_inscription = "2018-11-11"
                  deadline_course = "2017-10-10"
                  url_cover = "https://gerenciales.com/img/eventos/767_derecho_tributario_sl.jpg"
                  url = "https://image.slidesharecdn.com/presentacin1-160123023812/95/derecho-tributario-1-638.jpg?cb=1453516874"
                  description = '<div class="analisis">

                                      <p>

                                        El Máster en Estudios Avanzados de Derecho Financiero y Tributario constituye un proyecto conjunto de
                                        titulación superior avalado por la Facultad de Derecho de la Universidad Complutense de Madrid (UCM) y la Facultad de Ciencias Sociales, Jurídicas y Humanidades de la Universidad a Distancia de Madrid (UDIMA).
                                        Su diseño responde a la necesaria profundización en la investigación y orientación práctica sobre el conjunto
                                        del sistema tributario español y comparado, así como de las demás instituciones hacendísticas, dada la demanda creciente de especialistas en el área fiscal.
                                        El especial valor formativo del Derecho Financiero y Tributario hace que su enseñanza e investigación no se justifique, solamente, por razones prácticas o profesionales,
                                        dados los numerosos problemas que plantea la constante mutabilidad de la legislación financiera, la perspectiva particular de presentarse de instituciones y figuras jurídicas en el campo financiero y la cada vez mayor
                                        complejidad del sistema fiscal español ante las exigencias de globalización económica.
                                        Todo ello determina la necesidad de comprender las bases del ordenamiento jurídico financiero en sus múltiples relaciones con problemas prácticos concretos y, al propio tiempo, con el bagaje proporcionado por el
                                        conocimiento teórico avanzado para la satisfactoria formación de especialistas en el campo de las finanzas públicas.
                                        El Máster responde a la combinación de ambos enfoques, propiciando la profundización en las cuestiones centrales y dogmáticas pero sin desatender la orientación práctica de los futuros docentes y cultivadores de esta materia,
                                        pues se trata de conjugar la investigación del Derecho Financiero y el conocimiento de los problemas concretos de la fiscalidad para resultar un buen profesional en este ámbito.
                                        Por otro lado, este Máster no es el fruto de la improvisación, sino de una dilatada experiencia en los estudios de posgrado del profesorado del programa de Derecho Financiero y Tributario de la UCM y de la intensa actividad
                                        formativa realizada desde su creación por el Centro de Estudios Financieros, principal promotor de la UDIMA.
                                        la necesaria conexión entre el Derecho de los gastos públicos y de los Presupuestos con el estudio de los recursos públicos, fundamentalmente tributarios; la integración del conocimiento de los problemas propios del sistema fiscal español
                                        con todo el conjunto de normas y principios de la Unión Europea y otros marcos de relación internacional, potenciando el tratamiento del Derecho
                                        tributario internacional y favoreciendo la comprensión de los sistemas internacionales de tutela de las garantías de los contribuyentes; analizando la forma de resolver, en otros sistemas fiscales, los problemas que afectan al
                                        Ambas Universidades han tenido en cuenta, además, para la configuración del plan de estudios del Máster, la legislación vigente, planes de titulaciones similares y consejos de cualificados referentes externos, tanto públicos como privados, que abogaron por ofrecer un Título avanzado e innovador que conjugue la investigación con el interés profesional;
                                        Derecho Financiero de nuestro tiempo (estabilidad y coordinación presupuestarias, ejercicio leal y cooperativo de competencias financieras en distintos niveles de gobierno, diseño de técnicas de prevención de la evasión y fraude fiscal, etc.).
                                        El Máster en Estudios Avanzados de Derecho Financiero y Tributario ofrece líneas de investigación para la posterior realización de la Tesis Doctoral conducente al Título de Doctor y sus enseñanzas combinan espacios directos de docencia presencial y otros de carácter virtual, habiendo resultado verificado favorablemente por la Agencia Nacional de Calidad y Acreditación.

                                      <img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_courses/images/course_course_id/image_id/medium/image_name" style="width: 400px;"

                                      <footer class="definicion-pie">
                                    		<a href="https://www.definicionabc.com/?s=Derecho Tributario#resultados" rel="nofollow">&gt;&gt; Siguiente &gt;&gt;</a>
                                  		</footer>


                      			</div>'


                @course_8 = create_course(name_course,scoping,prelation,active,category_id, start_date,deadline_course,deadline_inscription,description,url,url_cover)

                create_tag(["tributario","parte 2","derecho", "master"],@course_8)

                #------------------------------- Curso 9


                name_course = "Aprenda a Programar con ruby Parte 3"
                scoping = 2
                prelation = 1
                category_id = @categories_id.at(1).id #Tecnologia
                active = 0
                start_date = "2018-11-09"
                deadline_inscription = "2018-11-05"
                deadline_course = "2018-12-09"
                description = '<p>Para evitar arrancar dando definiciones teóricas que resulten difíciles de entender, vamos ir directo a tratar de explicar AOP (Aspect-Oriented Programming) con un ejemplo.

                Supongamos que estamos trabajando en la interfaz de usuario de una aplicación. Como queremos trabajar con el patrón MVC, y estamos utilizando una arquitectura stand-alone de escritorio, es decir lo que se llama "cliente pesado" no tenemos ninguna restricción en cuanto al vínculo entre los elementos de la UI y nuestro modelo.

                Nos gustaría que el modelo se actualice ante eventos de la vista, pero también que la vista se actualice ante eventos del modelo.
                Entonces, una buena solución para esto es que nuestros objetos sean Observables, de modo de que los controles de la vista podrán registrarse como Observers para actualizarse ante eventos.
                E igualmente mantenemos el desacoplamiento entre el modelo y la vista.</p>'
                url_cover = ""
                url = ""

                @course_9 = create_course(name_course,scoping,prelation,active,category_id, start_date,deadline_course,deadline_inscription,description,url,url_cover)

                create_tag(["ruby","programacion","rails"],@course_9)

                departments = Array.new

                departments.push(@department.at(0))
                departments.push(@department.at(1))
                departments.push(@department.at(5))
                departments.push(@department.at(3))
                departments.push(@department.at(4))

                create_relation_department_course(@course_9,departments)


                #------------------------------- Curso 10

              name_course = "Percepción de los colores"
              scoping = 1
              prelation = 1
              category_id = @categories_id.at(0).id #Arte
              active = 1
              start_date = "2018-09-09"
              deadline_inscription = "2018-11-30"
              deadline_course = "2018-12-15"
              description = '
              <div class="field-item odd" property="content:encoded"><p style="text-align: justify;"><a class="menu_lateral" href="http://localhost/percepcion/node/8" style="margin: 0px; padding: 0px; border-width: 0px; vertical-align: baseline; color: rgb(0, 116, 189); text-decoration: none;">4. La <span data-scayt_word="percepción" data-scaytid="74">percepción</span> del color</a></p>
              <p style="text-align: justify;"><u><span data-scayt_word="Introducción" data-scaytid="674">Introducción</span></u></p>
              <p style="text-align: justify;">&nbsp;</p>
              <p style="text-align: justify;">La <span data-scayt_word="cualidad" data-scaytid="76">cualidad</span> <span data-scayt_word="perceptiva" data-scaytid="77">perceptiva</span> del color,
               <span data-scayt_word="tal" data-scaytid="78">tal</span> <span data-scayt_word="vez" data-scaytid="80">vez</span> sea la <span data-scayt_word="más" data-scaytid="81">más</span>
              <span data-scayt_word="obvia" data-scaytid="83">obvia</span> de <span data-scayt_word="cuantas" data-scaytid="84">cuantas</span>
              <span data-scayt_word="experimentamos" data-scaytid="85">experimentamos</span> <span data-scayt_word="subjetivamente" data-scaytid="86">
              subjetivamente</span>, sin embargo, <span data-scayt_word="objetivamente" data-scaytid="87">objetivamente</span> <span data-scayt_word="hablando" data-scaytid="88">hablando</span>
               el color no <span data-scayt_word="existe" data-scaytid="89">existe</span> <span data-scayt_word="como" data-scaytid="91">como</span>
             <span data-scayt_word="tal" data-scaytid="79">tal</span> en la <span data-scayt_word="realidad" data-scaytid="92">realidad</span>
             <span data-scayt_word="física" data-scaytid="93">física</span>, <span data-scayt_word="únicamente" data-scaytid="94">únicamente</span>
             <span data-scayt_word="estamos" data-scaytid="108">estamos</span> <span data-scayt_word="decidiendo" data-scaytid="109">decidiendo</span> y
             <span data-scayt_word="realizando" data-scaytid="110">realizando</span> <span data-scayt_word="juicios" data-scaytid="111">juicios</span>
              <span data-scayt_word="acerca" data-scaytid="112">acerca</span> del color. <span data-scayt_word="Así" data-scaytid="113">Así</span>,
              <div class="divimg" style="text-align: center;"><br><br><br><span data-scayt_word="FIGURA" data-scaytid="299">FIGURA</span> 1.-
              <span data-scayt_word="Análisis" data-scaytid="300">Análisis</span> de la <span data-scayt_word="luz" data-scaytid="237">luz</span>
              <span data-scayt_word="blanca" data-scaytid="240">blanca</span>.</div>
              <p style="text-align: justify;">&nbsp;</p>
              <p style="text-align: justify;"><span data-scayt_word="Además" data-scaytid="307">Además</span>
               del <span data-scayt_word="análisis" data-scaytid="308">análisis</span> o <span data-scayt_word="descomposición" data-scaytid="309">descomposición</span>
               de la <span data-scayt_word="luz" data-scaytid="238">luz</span> <span data-scayt_word="blanca" data-scaytid="241">blanca</span>,
               <span data-scayt_word="también" data-scaytid="310">también</span>, <span data-scayt_word="llevó" data-scaytid="311">llevó</span> a
               <span data-scayt_word="cabo" data-scaytid="312">cabo</span> el <span data-scayt_word="proceso" data-scaytid="313">proceso</span>
               <span data-scayt_word="recíproco" data-scaytid="314">recíproco</span>, la <span data-scayt_word="síntesis" data-scaytid="315">síntesis</span>
                de la <span data-scayt_word="luz" data-scaytid="239">luz</span> <span data-scayt_word="blanca" data-scaytid="242">blanca</span> a
              <span data-scayt_word="partir" data-scaytid="316">partir</span> de los <span data-scayt_word="siete" data-scaytid="243">siete</span>
              <span data-scayt_word="colores" data-scaytid="246">colores</span> <span data-scayt_word="componentes" data-scaytid="322">componentes</span>,
               <span data-scayt_word="mediante" data-scaytid="248">mediante</span> el <span data-scayt_word="denominado" data-scaytid="324">denominado</span>
               disco de Newton, en el <span data-scayt_word="cual" data-scaytid="325">cual</span> <span data-scayt_word="colocaba" data-scaytid="326">colocaba</span>
              en <span data-scayt_word="siete" data-scaytid="244">siete</span> <span data-scayt_word="sectores" data-scaytid="327">sectores</span> los
              <span data-scayt_word="siete" data-scaytid="245">siete</span> <span data-scayt_word="colores" data-scaytid="247">colores</span>
             <span data-scayt_word="que" data-scaytid="249">que</span> el <span data-scayt_word="denominaba" data-scaytid="330">denominaba</span>
             <span data-scayt_word="primarios" data-scaytid="331">primarios</span> y <span data-scayt_word="hacía" data-scaytid="332">hacía</span>
             <span data-scayt_word="rotar" data-scaytid="333">rotar</span> <span data-scayt_word="dicho" data-scaytid="334">dicho</span> disco a
             <span data-scayt_word="tal" data-scaytid="251">tal</span> <span data-scayt_word="velocidad" data-scaytid="336">velocidad</span>
             <span data-scayt_word="que" data-scaytid="250">que</span> se <span data-scayt_word="experimentaba" data-scaytid="337">experimentaba</span>
              la <span data-scayt_word="sensación" data-scaytid="338">sensación</span> de <span data-scayt_word="ver" data-scaytid="339">ver</span>
              un disco <span data-scayt_word="blanco" data-scaytid="340">blanco</span>.</p>
              <p style="text-align: justify;">&nbsp;</p>
              <div class="divimg" style="text-align: center;"><br>

                  <img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_courses/images/course_course_id/image_id/medium/image_name" style="width: 400px;"

               '
              url_cover = "http://www.ub.edu/pa1/sites/default/files/fig4-1.jpg"
              url = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/63/Dispersion_prism.jpg/400px-Dispersion_prism.jpg"

              @course_10 = create_course(name_course, scoping, prelation, active, category_id, start_date, deadline_course, deadline_inscription, description,url,url_cover)

              create_tag(["colores","XVII","cualidad","arte"],@course_10)


              #------------------------------- Curso 11

            name_course = "Historia del Antiguo Egipto. El Contexto del arte egipcio"
            scoping = 1
            prelation = 1
            category_id = @categories_id.at(0).id #Arte
            active = 1
            start_date = "2018-09-09"
            deadline_inscription = "2018-11-30"
            deadline_course = "2018-12-15"
            description = '
             <div>
               <p>
               La geografía del Antiguo Egipto es muy significativa y va a influir muchísimo en su arte. Egipto está situado en el nordeste de África y está muy aislado de otros países por su situación geográfica.
               Sus límites son: por el oeste, el desierto de Libia; por el este, el desierto de Arabia; por el norte el mar Mediterráneo y por el sur el macizo de Etiopía y el desierto de Nubia.
               Está recorrido de sur a norte por el río Nilo, que va a tener muchísima importancia en el desarrollo de esta civilización.
               (Heródoto dice "Egipto es un don del Nilo"). Al Nilo le llaman río de los dioses ya que tiene un carácter sagrado y es honrado por los egipcios.
                El Nilo da vida al valle que se desarrolla a lo largo de él. Este valle va a tener una anchura muy pequeña, de 5 a 30 km, dependiendo de las zonas. Es un río muy irregular en cuanto al caudal debido a las lluvias monzónicas,
                por lo que crea inundaciones, que beneficiaban la fertilidad, por lo que la cosecha depende de las crecidas del Nilo, y de ella el trabajo y la vida. Desde finales de junio empieza a aumentar su caudal y va arrastrando en un principio malas hierbas y más tarde el limo, que se deposita en el suelo, momento que se aprovecha para sembrar.
                 Esto sucede varias veces al año por lo que Egipto se convierte en un territorio muy rico y fértil.
               Para controlar el agua aparecen los nilómetros, pozos con señales para medir el nivel del agua para anticiparse al peligro de inundaciones, y en ese caso, construir diques. Aunque este sistema provocaba mucho trabajo, se han seguido usando hasta el siglo XX por la construcción de la presa de Asuán en 1902 y 1971.

               Por tanto, la de Egipto es una sociedad fluvial, y ello repercute en el arte: las pinturas y relieves encontrados principalmente en las tumbas reflejan la importancia del río en la vida: transporte, pesca, etc.

               Además, el río, las tormentas, etc. influyen en la sociedad creando supersticiones y una religión en la que los dioses están relacionados con fenómenos naturales. Hay un gran misterio en torno a la religión y la divinidad y el más allá van a regir toda la vida.

               Egipto está dividido en dos zonas: el Bajo Egipto, que es la zona del Norte, la zona del delta, y el Alto Egipto, que es la zona del sur, a partir de Memphis. Estas dos zonas van a estar representadas de forma iconográfica en dos flores: la flor del papiro representa el Bajo Egipto, mientras que la flor de loto representa el Alto Egipto.
               </p>

             </div>
            '
            url_cover = "https://eacnur.org/blog/wp-content/uploads/2016/02/iStock_000009278398_Small.jpg"
            url = "https://egipto.travelguia.net/files/2008/08/egipto_historia4.jpg"

            @course_11 = create_course(name_course, scoping, prelation, active, category_id, start_date, deadline_course, deadline_inscription, description,url,url_cover)

            create_tag(["egipto","historia","arte", "AC", "faraones"],@course_11)

              #------------------------------- Curso 12

            name_course = "Técnicas de dibujo"
            scoping = 1
            prelation = 1
            category_id = @categories_id.at(0).id #Arte
            active = 1
            start_date = "2018-09-09"
            deadline_inscription = "2018-11-30"
            deadline_course = "2018-12-15"
            description = '
             <div>
               <ol>
                 <li>Carboncillos, barras de carbón, lápices de grafito, tintas, rotuladores, lápices de color, barras o lápices de pastel e
                  incluso pinceles para dibujar…</li>
                 <li>El caballete con tablero para grandes formatos. También se utilizan las mesas de dibujo, que tienen una inclinación más baja
                   cerca del dibujante. Para evitar las deformaciones y tener más comodidad al dibujar hemos de intentar que nuestra vista sea
                   perpendicular al papel. El papel se fija en el tablero con chinchetas o celo de papel.</li>
                 <li>Los papeles para dibujo. Los más famosos son Canson, Ingres y Fabriano, pero hay una gran variedad. Los papeles pueden ser de
                   color blanco (clásico) o con color. El papel puede ser satinado, no satinado, más o menos absorvente, de grosor mayor o menor, etc,
                   y debemos escogerlo según la especialidad de dibujo que vayamos a realizar.</li>
                 <li>Difuminos, para difuminar el trazo del lápiz o carbón.</li>
                 <li>Esponjas, pañuelos de lana, trapos, para limpiar y difuminar.</li>
                 <li>Cutter y sacapuntas, para preparar los lápices.</li>
                 <li>Cinta adhesiva para papel para reservas o para fijar el papel.</li>
                 <li>Reglas, tanto rígidas como cuerdas flexibles, para tomar medidas y crear cuadrículas.</li>
                 <li>Fijativo para que el dibujo no se desprenda del papel una vez finalizado o por fases de dibujo que se van fijando.</li>
                 <li>Goma de borrar, para corregir o sacar luces al carboncillo.</li>
               </ol>

             </div>
            '
            url_cover = "https://upload.wikimedia.org/wikipedia/commons/4/4f/Pittura-Painting4.JPG"
            url = ""

            @course_12 = create_course(name_course, scoping, prelation, active, category_id, start_date, deadline_course, deadline_inscription, description,url,url_cover)

            create_tag(["egipto","historia","arte", "AC", "faraones"],@course_12)



            #------------------------------- Curso 13

            name_course = "Matematicas Avanzadas"
            scoping = 1
            prelation = 0
            category_id = @categories_id.at(2).id #Logica
            active = 1
            start_date = "2018-09-15"
            deadline_inscription = "2018-09-30"
            deadline_course = "2018-12-01"
            description = ' <div >
                              <p>
                                En general las personas con un cierto dominio de matemáticas avanzadas han dedicada entre 5 y 10 años a
                                estudiar numerosas ramas de las matemáticas. Sin un trabajo continuado, de varias horas al día posiblemente es muy
                                difícil para cualquier individuo comprender matemáticas avanzadas.
                              </p>
                              <p>
                              Yo he tratado de estudiar un buen número de teorías matemáticas desarrolladas a finales del siglo XIX y
                              la primera mitad del siglo XX. En muchos aspectos, a pesar de que llevo unos 10 años en ello, no he podido
                               pasar de resultados de los años 1920 y encuentro inmensamente difícil avanzar en teorías más recientes como sheaf theory,
                                homogical algrebra o K-theory.
                              </p>
                              <p>
                                Desde que empecé a intentar ver qué se ha hecho en matemáticas durante el siglo XX, tengo claro pq después de David Hilbert
                                existen muy pocos matemáticos que hayan destacado en ramas alejadas de las matemáticas. Realmente hoy en día es muy difícil
                                dominar adecuadamente los desarrollos recientes en diferentes ramas de las matemáticas. Por eso los matemáticos, han tendido
                                 a la hiperespecialización.
                               </p>
                               <p class="qtext_para">Antes de abordar cualquier tema avanzado, primero es necesario conocer algo de los temas básicos e intermedios:</p>
                               <ol>
                                 <li>Álgebra y Trigonometría.</li><li>Álgebra Superior.</li>
                                 <li>Geometría Analítica en el Plano y en el Espacio.</li>
                                 <li>Álgebra Lineal.</li><li>Lógica y Conjuntos.</li>
                                 <li>Álgebra Moderna.</li><li>Cálculo Diferencial e Integral en una y varias variables.</li>
                                 <li>Probabilidad y Estadística.</li><li>Variable Compleja.</li><li>Análisis Matemático.</li>
                                 <li>Teoría de la Medida.</li>
                                 <li>Topología.</li>
                                 <li>Métodos Matemáticos.</li>
                               </ol>
                            </div>
                                  '
            url_cover = "http://i88.servimg.com/u/f88/14/48/98/62/image10.png"
            url = ""

            @course_13 = create_course(name_course, scoping, prelation, active, category_id, start_date, deadline_course, deadline_inscription, description,url,url_cover)

            create_tag(["geometria","topologia","metodos","matematica","avanzado","integrales"],@course_13)


            #------------------------------- Curso 14

            name_course = "Estadística"
            scoping = 1
            prelation = 0
            category_id = @categories_id.at(2).id #Logica
            active = 1
            start_date = "2018-09-15"
            deadline_inscription = "2018-09-30"
            deadline_course = "2018-12-01"
            description = ' <div >
                              <div class="texto-global">
                                <div class="anuncios-desktop">
                                  <ins class="adsbygoogle" style="display:inline-block;width:300px;height:250px" data-ad-client="ca-pub-5928357609385979" data-ad-slot="8787234445" hkknvi6="" hidden=""></ins>
                                  </div>
                              <p>La estadística es la base del conocimiento práctico y real. Su definición.-
                              La estadística es una de las ramas de la ciencia matemática que se centra en el trabajo con datos e
                              informaciones que son ya de por sí numéricos o que ella misma se encarga de transformar en números.
                              La estadística, si bien es una ciencia de extracción exacta, tiene una injerencia directa en cuestiones
                              sociales por lo cual su utilidad práctica es mucho más comprensible que lo que sucede normalmente con otras
                               <a title="ciencias exactas" href="https://www.importancia.org/ciencias-exactas.php">ciencias exactas</a> como la matemática.</p>
                              <p>A diferencia de otras ramas de la matemática que poseen una parte importante de abstracción, la estadística
                              tiene aplicaciones directas y concretas en la vida real ya que toma los números y cifras de diferentes fenómenos
                              sociales como por ejemplo la desocupación, la tasa de mortalidad, la de natalidad y muchos otros datos incluso más
                              complejos.</p>

                              <img class="fr-fic fr-dib fr-draggable" src="/system/multimedia_courses/images/course_course_id/image_id/medium/image_name" style="width: 400px;"

                              <p>Podemos decir que la función principal de la estadística es justamente la recolección y agrupamiento de datos
                              de diverso tipo para construir con ellos informes estadísticos que nos den idea sobre diferentes y muy variados temas,
                               siempre desde un punto de vista cuantitativo y no cualitativo. Esto es muy importante de remarcar ya que la estadística
                               se convierte entonces en una ciencia que nos habla de cantidades (por ejemplo, cuántas personas viven en un país por metro
                                cuadrado) pero no nos da información directa sobre la
                                <a title="calidad de vida" href="https://www.importancia.org/calidad-de-vida.php">calidad de vida</a> de esas personas.
                                 En este sentido podemos decir que se presentan varias limitaciones ya que no permite conocer más que numéricamente aspectos
                                 que requieren un trabajo más complejo y profundo. </p>
                              <h3>El aspecto cuantitativo como centro de la estadística y su influencia en la mejora de la calidad de vida</h3>
                              <p>Sin embargo, a pesar de lo mencionado en el párrafo anterior, lo interesante de la estadística como ciencia es que en
                               muchos casos, la información cuantitativa que nos brinda nos permite conocer a ese nivel mucho mejor a una sociedad, por
                               ejemplo cuántas personas viven en un país, cuál es la tasa de desempleo, cuál es la tasa de indigencia o pobreza, cuál es el
                                nivel promedio de educación de esa sociedad, etc. Todos estos datos numéricos son utilizados por los responsables del Estado a través de sus distintos organismos y secretarías para luego realizar proyectos de diferente tipo que tengan que ver con mejorar esa situación o mantenerla en el caso de que sea buena.</p>
                              <p><a href="https://www.importancia.org/wp-content/uploads/politica-de-la/EstadIstica-2.jpg"></a>En algunos casos, aunque no
                              directamente, la estadística también nos permite inferir (no conocer) la calidad de vida de una población ya que si encontramos
                               altas tasas de desempleo, pobreza y marginalidad podremos suponer que la calidad de vida es muy baja.</p>
                              <p>La estadística tiene una utilidad no sólo en aspectos sociales si no que también sirve para todo tipo de
                              <a title="investigación científica" href="https://www.importancia.org/investigacion-cientifica.php">investigación científica</a>
                              si se tiene en cuenta que los <a title="datos estadísticos" href="https://www.importancia.org/datos-estadisticos.php">datos
                              estadísticos</a> son el resultado de varios casos de entre los cuales se toma un promedio. Así, una estadística puede servir
                              para una <a title="investigación" href="https://www.importancia.org/investigacion.php">investigación</a> científica al demostrar
                               que un porcentaje determinado de los casos observados representó un resultado particular y no otro. También se utiliza por
                                ejemplo para conocer el planeta en el que vivimos y darnos datos sobre las proporciones de recursos renovables, sobre las
                                superficies de los países, la presencia de determinados biomas o no, etc. </p>
                              <h3>Los problemas que se relacionan con las estadísticas y su mal uso</h3>
                              <p><a href="https://www.importancia.org/wp-content/uploads/politica-de-la/EstadIstica-3.jpg"></a>Como ocurre con cada
                              actividad humana, las estadísticas no son perfectas y muchas veces pueden presentar errores. Además, al ser realizadas
                              por humanos también debemos contar con una cuota de subjetividad y esto es lo que genera que algunos índices, al ser medidos
                               por diferentes personas con distintas posturas políticas o económicas, den como resultado diferentes números. Esto es muy
                               común por ejemplo respecto a los posibles resultados de elecciones políticas que marcan también decisiones políticas o incluso
                                propaganda de algunas consultoras hacia determinados candidatos.</p>
                              <p>En estos casos, las estadísticas se ven malversadas y son fraudulentas, lo cual significa un gran problema ético y moral
                              respecto de un sinfín de temáticas porque se considera que el público debe recibir información lo más verídica posible
                              especialmente si se trata de temas sensibles y que pueden influir en la calidad de vida de las personas directamente.</p>


                              </div>
                            </div>
                                  '
            url_cover = "https://www.definicionabc.com/wp-content/uploads/estadistica.jpg"
            url = "https://www.importancia.org/wp-content/uploads/estad%C3%ADstica-291x300.jpg"

            @course_14 = create_course(name_course, scoping, prelation, active, category_id, start_date, deadline_course, deadline_inscription, description,url,url_cover)

            create_tag(["datos","estadistica","importancia","matematica","avanzado","problemas"],@course_14)


                      #------------------------------- Curso 15

                      name_course = "Estadística"
                      scoping = 1
                      prelation = 0
                      category_id = @categories_id.at(1).id #Tecnologia
                      active = 1
                      start_date = "2018-09-15"
                      deadline_inscription = "2018-09-30"
                      deadline_course = "2018-12-01"
                      description = ' <div >
                                        <p>
                                          Bueno, te voy a resumir un poco esto, porque como siempre, me podría quedar escribiendo toda la vida si lo quisiera, pero como no es necesario, resumiré esto.

                                          C++ es algo así como la evolución del lenguaje C. La intención de su creación fue el extender al exitoso lenguaje de programación C con mecanismos
                                           que permitan la manipulación de objetos. En ese sentido, desde el punto de vista de los lenguajes orientados a objetos, el C++ es un lenguaje híbrido.
                                            La historia de C (predecesor de C++) parte de un lenguaje anterior, el lenguaje B, escrito por Ken Thompson en 1970 con el objetivo de recodificar el
                                            sistema operativo UNIX, que hasta el momento se había programado en ensamblador. Lo malo del lenguaje ensamblador era que lo ligaba a una serie de máquinas
                                            concretas, por lo que conseguir un lenguaje abstraído de cada máquina conseguiría una portabilidad del sistema muchísimo mayor. A su vez B fue inspirado en el
                                            BCPL de Martin Richards, diseñado tres años antes.

                                          En 1972 es Dennis Ritchie (de los Laboratorios Bell de AT&T) quien diseña finalmente C a partir del B de Thompson, aportando un diseño de tipos y
                                          estructuras de datos que consiguen una claridad y eficacia en el lenguaje muy superior. Es un lenguaje que permite realizar una programación estructurada economizando
                                           las expresiones, con abundancia de operadores y tipos de datos (aunque los básicos sean pocos), codificando en alto y bajo nivel simultáneamente, reemplazando ventajosamente
                                            la programación en ensamblador y permitiendo una utilización natural de las funciones primitivas del sistema.

                                          Durante muchos años no existieron reglas estándar para el lenguaje, pero en 1983 se decide formar un comité con el objetivo de crear el estándar ANSI. El proceso dura seis
                                           años y a principios de los 90 el estándar es reconocido por la ISO (Organización Internacional de Estándares) y comienza a comercializarse con el nombre ANSI C.

                                          Nota: Lo que verás a continuación es un algoritmo escrito en C, lo cual es una pequeña aproximación a lo que es C++ como tal, no te preocupes si no entiendes lo que dice o
                                          hace este código, pues más adelante lo comprenderás a la perfección. Este código, escribe en pantalla la frase "Hola Mundo" (sin las comillas).
                                        </p>
                                        <code class="hljs cpp">
                                            <span class="hljs-comment">/* "Hola mundo" escrito en C */</span>
                                            <span class="hljs-meta">#<span class="hljs-meta-keyword">include</span> <span class="hljs-meta-string">"stdio.h"</span></span>
                                            <span class="hljs-function"><span class="hljs-keyword">void</span> <span class="hljs-title">main</span><span class="hljs-params">()</span>
                                            </span>{
                                                <span class="hljs-built_in">printf</span>( <span class="hljs-string">"Hola mundo"</span> );
                                            }
                                        </code>
                                        <p>
                                          Paralelamente, en 1980 surge C++ de la mano de Bjarne Stroustrup (también de Laboratorios Bell de AT&T). Diseña este lenguaje con el objetivo de añadir
                                          a C nuevas características: clases y funciones virtuales (de SIMULA 67), tipos genéricos y expresiones (de ADA), la posibilidad de declarar variables en
                                          cualquier punto del programa (de ALGOL 68), y sobre todo, un auténtico motor de objetos con herencia múltiple que permite combinar la programación imperativa d
                                          e C con la programación orientada a objetos. Estas nuevas características mantienen siempre la esencia del lenguaje C: otorgan el control absoluto de la aplicación
                                          al programador, consiguiendo una velocidad muy superior a la ofrecida por otros lenguajes. El nombre C++ fue propuesto por Rick Mascitti en el año 1983, cuando el
                                          lenguaje fue utilizado por primera vez fuera de un laboratorio científico. Antes se había usado el nombre "C con clases". En C++, la expresión "C++" significa "incremento de C"
                                           y se refiere a que C++ es una extensión de C. El siguiente hecho fundamental en la evolución de C++ es sin duda la incorporación de la librería STL años más tarde, obra de
                                           Alexander Stepanov y Andrew Koening. Esta librería de clases con contenedores y algoritmos genéricos proporciona a C++ una potencia única entre los lenguajes de alto nivel.
                                          Debido al éxito del lenguaje, en 1990 se reúnen las organizaciones ANSI e ISO para definir un estándar que formalice el lenguaje. El proceso culmina en 1998 con la aprobación
                                          del ANSI C++.
                                          Finalizaremos esta sección con el famoso "Hola Mundo" en C++, puedes comparar la diferencia entre ambos códigos y determinar las nuevas caracteristicas que tiene C++ sobre C.
                                        </p>
                                      </div>
                                            '
                      url_cover = "https://1.bp.blogspot.com/-PKlqhC0hk44/V_51K-4vUgI/AAAAAAAACtQ/dh_03AMMi5kqOUMh7uUEM7mLQwnaYD9qQCLcB/s1600/Curso%2Bde%2BProgramaci%25C3%25B3n%2BC%252B%252B.jpeg"
                      url = ""

                      @course_15 = create_course(name_course, scoping, prelation, active, category_id, start_date, deadline_course, deadline_inscription, description,url,url_cover)

                      create_tag(["datos","estadistica","importancia","matematica","avanzado","problemas"],@course_15)


                      #------------------------------- Curso 16

                      name_course = "Derecho tributario III"
                      scoping = 1
                      prelation = 0
                      category_id = @categories_id.at(3).id #Derecho
                      active = 0
                      start_date = "2018-01-01"
                      deadline_inscription = "2018-01-20"
                      deadline_course = "2018-02-20"
                      url_cover = "https://cdn.slidesharecdn.com/ss_thumbnails/derechotributario-161126151108-thumbnail-4.jpg?cb=1480173267"
                      url = ""
                      description = '<div class="analisis">

                                          <p>

                                            El Máster en Estudios Avanzados de Derecho Financiero y Tributario constituye un proyecto conjunto de
                                            titulación superior avalado por la Facultad de Derecho de la Universidad Complutense de Madrid (UCM) y la Facultad de Ciencias Sociales, Jurídicas y Humanidades de la Universidad a Distancia de Madrid (UDIMA).
                                            Su diseño responde a la necesaria profundización en la investigación y orientación práctica sobre el conjunto
                                            del sistema tributario español y comparado, así como de las demás instituciones hacendísticas, dada la demanda creciente de especialistas en el área fiscal.
                                            El especial valor formativo del Derecho Financiero y Tributario hace que su enseñanza e investigación no se justifique, solamente, por razones prácticas o profesionales,
                                            dados los numerosos problemas que plantea la constante mutabilidad de la legislación financiera, la perspectiva particular de presentarse de instituciones y figuras jurídicas en el campo financiero y la cada vez mayor
                                            complejidad del sistema fiscal español ante las exigencias de globalización económica.
                                            Todo ello determina la necesidad de comprender las bases del ordenamiento jurídico financiero en sus múltiples relaciones con problemas prácticos concretos y, al propio tiempo, con el bagaje proporcionado por el
                                            conocimiento teórico avanzado para la satisfactoria formación de especialistas en el campo de las finanzas públicas.
                                            El Máster responde a la combinación de ambos enfoques, propiciando la profundización en las cuestiones centrales y dogmáticas pero sin desatender la orientación práctica de los futuros docentes y cultivadores de esta materia,
                                            pues se trata de conjugar la investigación del Derecho Financiero y el conocimiento de los problemas concretos de la fiscalidad para resultar un buen profesional en este ámbito.
                                            Por otro lado, este Máster no es el fruto de la improvisación, sino de una dilatada experiencia en los estudios de posgrado del profesorado del programa de Derecho Financiero y Tributario de la UCM y de la intensa actividad
                                            formativa realizada desde su creación por el Centro de Estudios Financieros, principal promotor de la UDIMA.
                                            la necesaria conexión entre el Derecho de los gastos públicos y de los Presupuestos con el estudio de los recursos públicos, fundamentalmente tributarios; la integración del conocimiento de los problemas propios del sistema fiscal español
                                            con todo el conjunto de normas y principios de la Unión Europea y otros marcos de relación internacional, potenciando el tratamiento del Derecho
                                            tributario internacional y favoreciendo la comprensión de los sistemas internacionales de tutela de las garantías de los contribuyentes; analizando la forma de resolver, en otros sistemas fiscales, los problemas que afectan al
                                            Ambas Universidades han tenido en cuenta, además, para la configuración del plan de estudios del Máster, la legislación vigente, planes de titulaciones similares y consejos de cualificados referentes externos, tanto públicos como privados, que abogaron por ofrecer un Título avanzado e innovador que conjugue la investigación con el interés profesional;
                                            Derecho Financiero de nuestro tiempo (estabilidad y coordinación presupuestarias, ejercicio leal y cooperativo de competencias financieras en distintos niveles de gobierno, diseño de técnicas de prevención de la evasión y fraude fiscal, etc.).
                                            El Máster en Estudios Avanzados de Derecho Financiero y Tributario ofrece líneas de investigación para la posterior realización de la Tesis Doctoral conducente al Título de Doctor y sus enseñanzas combinan espacios directos de docencia presencial y otros de carácter virtual, habiendo resultado verificado favorablemente por la Agencia Nacional de Calidad y Acreditación.


                                          <footer class="definicion-pie">
                                            <a href="https://www.definicionabc.com/?s=Derecho Tributario#resultados" rel="nofollow">&gt;&gt; Siguiente &gt;&gt;</a>
                                          </footer>


                                </div>'


                    @course_16 = create_course(name_course,scoping,prelation,active,category_id, start_date,deadline_course,deadline_inscription,description,url,url_cover)

                    create_tag(["tributario","parte 2","derecho", "master"],@course_16)
