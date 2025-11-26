//
//  RecipeDataSource.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 14/11/25.
//

import Foundation

let recipeList = [

    // MARK: - RECETARIO DULCE

    CookbookRecipe(
        title: "Cake pops para Halloween",
        imageName: "imagen1",
        ingredients: [
            "165 gr. De Harina",
            "250 ml. De jugo de naranja",
            "1 cucharadita de ralladura de naranja",
            "170 gr. De azúcar",
            "1 cucharadita de bicarbonato sódico",
            "½ cucharadita de levadura en polvo",
            "Una pizca de sal",
            "80 ml. de aceite de girasol",
            "1 tableta de chocolate negro apto",
            "1 tableta de chocolate blanco apto",
            "Unos palos para cake pops",
            "200 gr de queso vegano en crema (o yogur espeso apto)"
        ],
        instructions: "1. Precalentar el horno a 180º C.\n2. Mezclar bien el aceite con el azúcar y la ralladura de naranja (ha de quedar bien batido).\n3. Incorporar el zumo de naranja.\n4. Añadir la harina tamizada junto con la levadura, el bicarbonato y la pizca de sal.\n5. Engrasar un molde para horno, espolvorearlo con harina y verter la mezcla. Hornear unos 30 minutos.\n6. Para los Cake Pops: En un bol, poner el queso vegano en crema.\n7. Desmenuzar el bizcocho sobre la crema y mezclar hasta hacer una masa.\n8. Hacer bolas o figuras y meter al congelador una hora.\n9. Deshacer los chocolates por separado.\n10. Manchar el palo con chocolate y pinchar en las bolas. Pinchar en un corcho y refrigerar.\n11. Decorar cubriendo con chocolate.",
        containsAllergens: [.gluten],
        freeFromAllergens: [.eggs, .dairy, .nuts, .soy], // Descomentado y ajustado
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Creme Brule",
        imageName: "imagen2",
        ingredients: [
            "2 tazas de leche de avena",
            "2/3 de taza de azúcar superfina",
            "1/4 taza de maicena",
            "2 cucharadas de extracto de vainilla",
            "1 cucharada de azúcar superfina (para la cubierta)"
        ],
        instructions: "1. Coloca todos los ingredientes en una licuadora y licúa hasta obtener una mezcla homogénea.\n2. Vierte en una cacerola y calienta a fuego medio, revolviendo con frecuencia hasta que espese (aprox. 5 minutos).\n3. Reparte uniformemente en 4 moldes de cerámica pequeños y refrigera durante 1 hora o toda la noche.\n4. Espolvorea azúcar superfina por encima de la crema y caramelízala con un soplete de cocina hasta que esté dorada.\n5. Dejar reposar durante 5 minutos y servir.",
        containsAllergens: [],
        freeFromAllergens: [.eggs, .dairy],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Mini - Brownie",
        imageName: "imagen3",
        ingredients: [
            "1 plátano maduro",
            "3 cucharadas soperas de harina de maíz",
            "3 cucharadas soperas de café con o sin cafeína",
            "3 cucharadas leche de soya",
            "1 cucharada sopera de aceite vegetal",
            "1 cucharada sopera de cacao",
            "1/2 cdita. de bicarbonato",
            "1/2 cdita. de vinagre"
        ],
        instructions: "1. Machacar en una taza el plátano con un tenedor.\n2. Añadir el resto de ingredientes y mezclar bien.\n3. Calentar 2 minutos al microondas.",
        containsAllergens: [.soy],
        freeFromAllergens: [.gluten, .dairy, .eggs],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Galletas con chispas de chocolate",
        imageName: "imagen4",
        ingredients: [
            "160 ml de aceite de oliva",
            "75 gr de azúcar moreno",
            "60 gr de azúcar blanco",
            "250 gr de harina auto leudante (o harina trigo + levadura)",
            "1 cucharada de maicena",
            "60 ml de leche de soya o de avena",
            "1 cucharadita de extracto de vainilla",
            "160 gr de chips de chocolate puro o trocitos"
        ],
        instructions: "1. Precalentar el horno a 180ºC.\n2. En un bol, tamizar la harina con levadura y la maicena. Reservar.\n3. En otro bol, batir el aceite con los dos tipos de azúcar.\n4. Incorporar la leche vegetal y batir hasta homogeneizar, añadir la vainilla.\n5. Añadir la mezcla de harina poco a poco y mezclar hasta obtener una masa.\n6. Incorporar los chips de chocolate.\n7. Formar bolitas, poner sobre papel de horno y aplastar un poco.\n8. Hornear 12-15 minutos hasta que estén doradas. Dejar enfriar.",
        containsAllergens: [.gluten, .soy],
        freeFromAllergens: [.dairy, .eggs, .nuts],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Bizcocho",
        imageName: "imagen5",
        ingredients: [
            "300 ml de leche (soja, arroz, avena)",
            "300 gr. de harina de trigo",
            "10 cucharadas soperas de aceite de oliva",
            "1 vaso de azúcar",
            "Ralladura de naranja o limón",
            "2 sobres de levadura (o 1 sobre y 1 plátano maduro)"
        ],
        instructions: "1. Precalentar el horno a 180ºC.\n2. Mezclar bien con batidora la leche vegetal, el azúcar y el aceite hasta conseguir textura espumosa.\n3. Añadir poco a poco harina, levadura y ralladura. Mezclar bien.\n4. Untar molde con aceite o papel de horno.\n5. Hornear durante 25 o 30 minutos.\n6. Nota: Si usas plátano, batirlo con los líquidos.",
        containsAllergens: [.gluten, .soy],
        freeFromAllergens: [.eggs, .dairy, .nuts],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Tarta de Manzana",
        imageName: "imagen6",
        ingredients: [
            "225 gr de harina integral de trigo",
            "100 gr de margarina",
            "30 ml de agua muy fría",
            "450 gr de manzanas",
            "15 ml de jugo de limón",
            "50 gr de azúcar moreno",
            "50 gr de uvas pasas (opcional)",
            "4 cdas mermelada durazno (glaseado)",
            "4 cdas agua (glaseado)",
            "2 cdas azúcar (glaseado)"
        ],
        instructions: "1. Mezclar margarina con harina hasta formar migas. Añadir agua fría para formar masa.\n2. Extender con rodillo y colocar en molde de 20cm.\n3. Precalentar horno a 190ºC.\n4. Mezclar manzanas rebanadas con jugo de limón y colocar sobre la masa.\n5. Espolvorear canela, azúcar y pasas.\n6. Hornear 30 minutos.\n7. Glaseado: Cocer mermelada, agua y azúcar 5 min, triturar y colar. Pintar la tarta fría.",
        containsAllergens: [.gluten],
        freeFromAllergens: [.eggs, .dairy, .nuts],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Galletas Navideñas",
        imageName: "imagen7",
        ingredients: [
            "250 gr harina sin gluten",
            "100 gr harina de arroz",
            "1 cuchara de semilla de linaza molida + 4 cucharas de agua",
            "100gr mantequilla vegana",
            "70 gr azúcar",
            "5 cucharas de jarabe de agave",
            "120 gr puré de calabaza",
            "1 cucharilla de canela",
            "1 cucharilla jengibre",
            "1 cucharilla nuez moscada",
            "1 cuchara levadura en polvo",
            "Un poco de sal"
        ],
        instructions: "1. Mezclar linaza con agua.\n2. Mezclar harinas, sal, levadura y especias.\n3. Batir mantequilla vegana con azúcar hasta acremar.\n4. Añadir mezcla de linaza, puré de calabaza y agave. Mezclar 1 min.\n5. Incorporar ingredientes secos a los líquidos.\n6. Refrigerar la masa 30 min / 1 hora.\n7. Precalentar horno a 175º C.\n8. Estirar la masa (1 cm grosor) y cortar formas.\n9. Hornear 8-10 min.",
        containsAllergens: [],
        freeFromAllergens: [.gluten, .dairy, .eggs],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Pastel de Zanahoria",
        imageName: "imagen8",
        ingredients: [
            "100 gr harina integral trigo",
            "100 gr harina trigo blanca",
            "15 gr canela molida",
            "5 gr nuez moscada rallada",
            "10 gr levadura",
            "100 gr margarina",
            "100 gr miel de abeja",
            "100 gr azúcar moreno",
            "225 gr zanahoria rallada",
            "Cobertura: 1 yogur soya, 30 gr jugo naranja, 1/2 taza azúcar glas"
        ],
        instructions: "1. Precalentar horno a 160ºC.\n2. Mezclar harinas, canela, nuez moscada y levadura.\n3. Derretir margarina con miel y azúcar. Mezclar con las harinas.\n4. Añadir zanahoria rallada.\n5. Poner en molde de 20 cm y hornear 1 hora.\n6. Dejar reposar 10 min y desmoldar.\n7. Mezclar ingredientes de cobertura y pintar la tarta.",
        containsAllergens: [.gluten, .soy],
        freeFromAllergens: [.eggs, .dairy],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Pancakes sin leche",
        imageName: "imagen9",
        ingredients: [
            "2 huevos grandes",
            "35 gr harina de almendra",
            "3 gr polvo para hornear",
            "4 ml vainilla natural",
            "0.5 gr canela en polvo",
            "40 gr puré plátano o manzana",
            "40 ml bebida vegetal sin azúcar",
            "10 ml aceite coco u oliva",
            "25 gr proteína vegetal en polvo"
        ],
        instructions: "1. Batir los huevos en bowl grande.\n2. Agregar puré, bebida vegetal, vainilla y aceite.\n3. En otro bowl mezclar secos: harina almendra, proteína, polvo hornear, canela.\n4. Incorporar secos a líquidos poco a poco.\n5. Calentar sartén con aceite.\n6. Verter 1/4 taza por pancake, cocinar 2-3 min por lado.",
        containsAllergens: [.eggs, .nuts],
        freeFromAllergens: [.dairy],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Barras de proteína con cocoa",
        imageName: "imagen10",
        ingredients: [
            "80 gr hojuelas de avena",
            "400 gr garbanzos cocidos",
            "40 gr semillas de chía",
            "170 gr dátiles deshuesados",
            "60 gr cacahuates tostados sin sal",
            "1 tira ralladura naranja",
            "30 ml jugo naranja",
            "50 gr proteína vegetal",
            "50 gr harina almendra",
            "30 gr cocoa en polvo",
            "1 cdita canela",
            "1 pizca sal",
            "50 gr pepita calabaza"
        ],
        instructions: "1. Forrar molde 20x20 cm.\n2. Moler avena en licuadora 30 seg.\n3. Añadir garbanzos, chía, dátiles, cacahuates, naranja, proteína, harina almendra, cocoa, canela y sal. Licuar 20 seg.\n4. Añadir pepitas y licuar 5 seg.\n5. Transferir al molde, presionar y congelar 1 hora o refrigerar 4 horas.\n6. Cortar en 10 barritas.",
        containsAllergens: [.nuts],
        freeFromAllergens: [.dairy, .eggs],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Pastel de cumpleaños de chocolate",
        imageName: "imagen11",
        ingredients: [
            "200gr harina de avena o trigo integral",
            "50gr cacao en polvo sin azúcar",
            "80gr azúcar mascabado",
            "1 cdita bicarbonato sodio",
            "1 cdita polvo para hornear",
            "1/2 cdita sal",
            "1 cdita canela",
            "2 plátanos maduros triturados",
            "220 ml bebida vegetal sin azúcar",
            "80 ml aceite vegetal",
            "1 cdita vainilla",
            "2 huevos (o sustituto linaza)",
            "Betún: 250gr camote cocido/plátano, 2-3 cdas cacao, 100gr crema cacahuate, miel agave, aceite coco"
        ],
        instructions: "1. Precalienta horno a 180ºC y engrasa 2 moldes de 20cm.\n2. Mezclar ingredientes secos del bizcocho.\n3. Mezclar ingredientes húmedos.\n4. Incorporar húmedos a secos sin batir demasiado.\n5. Hornear 30-35 minutos. Enfriar.\n6. Betún: Licuar todos los ingredientes del betún hasta obtener mezcla cremosa.\n7. Montar: Rellenar y cubrir con el betún. Decorar con fruta o nueces.",
        containsAllergens: [.gluten, .eggs],
        freeFromAllergens: [.dairy],
        isFavorite: false
    ),

    // MARK: - RECETARIO SALADO

    CookbookRecipe(
        title: "Masa de hojaldre",
        imageName: "imagen12",
        ingredients: [
            "500 g de harina de trigo de panadería",
            "400 g de mantequilla vegana o margarina vegana muy fría",
            "250 ml de agua fría",
            "1 cucharadita de sal"
        ],
        instructions: "1. Mezcla harina y sal. Añade agua y amasa hasta obtener masa uniforme. Refrigerar 30 min.\n2. Golpear la mantequilla entre papeles de horno hasta formar cuadrado de 15x15cm. Refrigerar.\n3. Estirar masa a 30x30cm, colocar mantequilla en centro y cerrar como sobre.\n4. Estirar la masa en rectángulo y doblar en tres (vuelta sencilla). Refrigerar 30 min.\n5. Repetir estirado y doblado 4 veces en total, girando 90º y refrigerando entre vueltas.\n6. Reposar 1 hora antes de usar.",
        containsAllergens: [.gluten],
        freeFromAllergens: [.dairy, .eggs],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Empanada de atún con champiñones",
        imageName: "imagen13",
        ingredients: [
            "350 gr de masa de hojaldre",
            "30 gr harina",
            "3 o 4 latas de atún en aceite",
            "1 lata aceitunas negras",
            "200 gr tomate frito casero",
            "1 bandeja de champiñones",
            "1/2 cebolla",
            "3 dientes de ajo",
            "Orégano, Pimienta y sal"
        ],
        instructions: "1. Extender 2/3 de la masa sobre bandeja de horno y pinchar con tenedor.\n2. Precalentar horno a 220ºC.\n3. Freír champiñones, luego añadir cebolla, ajo y especias.\n4. Añadir aceitunas y tomate frito (reservar un poco de tomate).\n5. Verter sofrito sobre la masa.\n6. Cubrir con el resto de la masa y cerrar bordes.\n7. Pintar con el tomate reservado y aceite.\n8. Hornear 35 minutos a 220ºC.",
        containsAllergens: [.gluten, .fish],
        freeFromAllergens: [.eggs, .dairy],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Mayonesa sin huevo",
        imageName: "imagen14",
        ingredients: [
            "220 gr de aceite de vegetal no refinado (1 taza)",
            "120 gr de leche de soya (1/2 taza)",
            "2 cucharaditas de vinagre de manzana",
            "Sal de mar al gusto"
        ],
        instructions: "1. Poner aceite, leche de soya, vinagre y sal en vaso batidora (mismos temperatura).\n2. Batir a velocidad media al fondo hasta emulsionar.\n3. Mover de abajo a arriba para integrar.\n4. Corregir de sal o textura (más leche si densa, más aceite si líquida).",
        containsAllergens: [.soy],
        freeFromAllergens: [.eggs],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Pizza vegetal",
        imageName: "imagen15",
        ingredients: [
            "Masa: 100gr agua templada, 25gr aceite oliva, 25gr levadura, 200gr harina fuerza, sal",
            "Relleno: 2-3 cebollas, 5 champiñones, 1/2 pimiento, 30ml aceite",
            "1 jitomate, 6 rebanadas tofu/queso vegano, 60gr aceitunas negras"
        ],
        instructions: "1. Masa: Mezclar agua, aceite, levadura. Añadir harina y sal. Amasar y reposar 20 min.\n2. Relleno: Sofreír cebolla, pimientos y champiñones. Reservar.\n3. Precalentar horno a 220ºC.\n4. Estirar masa en bandeja y pinchar.\n5. Cubrir con sofrito, tofu, jitomate y aceitunas.\n6. Hornear 15-20 min a 220ºC.",
        containsAllergens: [.gluten, .soy],
        freeFromAllergens: [.dairy, .eggs, .nuts],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Empanada de atún (Tradicional)",
        imageName: "imagen16",
        ingredients: [
            "350 gr masa hojaldre",
            "3-4 latas atún",
            "1 lata aceitunas negras",
            "200 gr puré jitomate",
            "250 gr champiñones",
            "1/2 cebolla, 3 ajos",
            "Orégano, sal, pimienta"
        ],
        instructions: "1. Extender 2/3 masa en bandeja y pinchar.\n2. Precalentar horno 220ºC.\n3. Freír champiñones, añadir cebolla, ajo, especias.\n4. Añadir aceitunas y puré de jitomate (reservar poco para pintar).\n5. Verter relleno sobre masa, cubrir con la tapa de masa y cerrar.\n6. Pintar con jitomate reservado.\n7. Hornear 35 min a 220ºC.",
        containsAllergens: [.gluten, .fish],
        freeFromAllergens: [.eggs],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Albóndigas en salsa",
        imageName: "imagen17",
        ingredients: [
            "Albóndigas: 2 ajos, 2 zanahorias/apio, 60gr pan molido sin gluten",
            "125ml leche avena, 1 cda maicena",
            "400gr carne picada, especias",
            "Salsa: 250gr cebolla, 2 ajos, 40ml aceite, 200gr tomate, 100ml vino blanco"
        ],
        instructions: "1. Picar ajo y verduras. Mezclar con pan, leche, maicena y especias.\n2. Incorporar carne y mezclar.\n3. Formar bolas y hornear a 180ºC por 20 min (vuelta a los 10).\n4. Salsa: Rehoga cebolla y ajo. Añade tomate, vino y agua. Cocer 10 min.\n5. Servir albóndigas con salsa.",
        containsAllergens: [],
        freeFromAllergens: [.eggs, .dairy, .gluten],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Masa para Crepas",
        imageName: "imagen18",
        ingredients: [
            "1 cucharada azúcar blanco",
            "1 cucharadita aceite oliva",
            "100 gr harina de trigo",
            "1 vasito agua mineral"
        ],
        instructions: "1. Mezcla harina con medio vaso de agua hasta quitar grumos.\n2. Añade azúcar y aceite.\n3. Mezclar y reposar.\n4. Cocinar en sartén engrasada extendiendo bien la masa. Dar la vuelta.",
        containsAllergens: [.gluten],
        freeFromAllergens: [.dairy, .eggs],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Lasaña",
        imageName: "imagen19",
        ingredients: [
            "Placas lasaña sin huevo/gluten",
            "Salsa: Ajo, cebolla, poro, zanahorias, apio, 400gr jitomate, champiñones, 500gr carne picada",
            "Bechamel: 65gr maicena, 800ml bebida vegetal, nuez moscada",
            "Pan molido con ajo y perejil"
        ],
        instructions: "1. Sofreír verduras trituradas y champiñones. Añadir carne y cocinar 30 min.\n2. Preparar pasta según paquete.\n3. Montar capas: Aceite, Pasta, Salsa, Pasta... Terminar con Pasta.\n4. Bechamel: Disolver maicena en bebida vegetal fría, calentar removiendo hasta espesar.\n5. Cubrir lasaña con bechamel, espolvorear pan y aceite.\n6. Gratinar 10 min.",
        containsAllergens: [],
        freeFromAllergens: [.eggs, .dairy, .gluten],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Crema de cilantro y espinacas",
        imageName: "imagen20",
        ingredients: [
            "200 gr brócoli",
            "200 gr zanahoria",
            "250 ml agua",
            "20 gr cilantro",
            "100 gr espinaca",
            "2 tortillas",
            "1 cda concentrado verduras",
            "100 gr cebolla",
            "1 diente ajo",
            "330 ml leche de coco"
        ],
        instructions: "1. Cocine brócoli y zanahoria al vapor (guarnición).\n2. Licuar agua, cilantro, espinacas, tortillas, concentrado, cebolla, ajo y leche de coco (1 min).\n3. Verter en olla y cocinar 25 min a fuego lento.\n4. Servir caliente acompañada de las verduras al vapor.",
        containsAllergens: [.gluten],
        freeFromAllergens: [.dairy],
        isFavorite: false
    ),

    CookbookRecipe(
        title: "Pollo relleno de espinacas y aguacate",
        imageName: "imagen21",
        ingredients: [
            "4 pechugas de pollo",
            "1 taza espinacas picadas",
            "1 aguacate en cubos",
            "2 dientes ajo picados",
            "2 cdas aceite oliva",
            "Jugo 1 limón",
            "1/2 taza nueces picadas",
            "Especias al gusto"
        ],
        instructions: "1. Hacer corte horizontal en pechugas para crear bolsillo.\n2. Mezclar espinacas, aguacate, ajo, nueces, limón y especias.\n3. Rellenar pechugas y cerrar con palillos.\n4. Dorar en sartén con aceite 4-5 min por lado.\n5. Hornear a 180ºC por 20 minutos.\n6. Retirar palillos y servir.",
        containsAllergens: [.nuts],
        freeFromAllergens: [.dairy, .eggs, .gluten],
        isFavorite: false
    )
]
