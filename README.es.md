# programming-tutor

**Un Agent-Skill para Claude Code / Cowork — un tutor personal paso a paso y práctico para aprender lenguajes de programación y frameworks, con Claude haciendo de profesor paciente.**

Tú trabajas en tu propio editor (VS Code recomendado) resolviendo pequeños ejercicios prácticos, iteras con revisiones de código y vas construyendo habilidades reales, un paso a la vez.

🌐 **Idiomas**: [日本語](./README.md) · [English](./README.en.md) · [中文](./README.zh.md) · **Español** · [Français](./README.fr.md)

---

## Para quién es esta skill

### ✅ Te va a encajar si

- Empiezas a programar, o vas a entrar en un lenguaje/framework nuevo
- Estudias por tu cuenta y quieres un plan estructurado más alguien que revise tu código al momento
- La documentación oficial existe, pero no sabes por dónde empezar ni en qué orden leerla
- Quieres que alguien mire tu código y no tienes a quién pedírselo
- Tienes tiempo fragmentado (15–60 minutos al día) y necesitas material que puedas completar en trozos cortos
- Ya sabes otro lenguaje y quieres aprender rápido las *formas idiomáticas* y los *errores típicos* del nuevo

### ⚠️ No te conviene si

- **Lo que quieres es que te escriba el código de producción.** Esta skill es para aprender. Para trabajo real, usa otro flujo.
- Quieres una aplicación terminada saltándote el aprendizaje
- Ya dominas la tecnología y solo buscas preguntas estilo diccionario

---

## Importante: esta skill es para aprender, no para producción

Esta skill proporciona **un entorno para aprender**. Ten en cuenta:

- **No le pidas que implemente tu trabajo.** El agente está diseñado para *no* darte la solución completa y guiarte con pistas. Si tienes prisa por entregar código, te va a frustrar.
- **Los planes, ejercicios y ejemplos generados son educativos.** Priorizan la claridad sobre la robustez de producción (seguridad, rendimiento, casos límite). No los copies tal cual a producción.
- **No pegues información confidencial.** Código interno de tu empresa, datos personales, API keys, etc., no deben aparecer en el chat de aprendizaje.
- **Contrasta con la documentación oficial.** El curriculum es *una* ruta recomendada, no *la única* verdad. Los ecosistemas cambian; confirma con la doc actual.

---

## Tecnologías soportadas

| Categoría | Tecnología | Fichero de referencia |
| --- | --- | --- |
| Lenguaje general | Python / JavaScript / TypeScript / Java / C# / Go / Ruby, etc. | `references/language-general.md` |
| .NET | C# / ASP.NET Core / EF Core | `references/dotnet.md` |
| Spring Boot | Java / Spring Boot / Spring Data JPA | `references/spring-boot.md` |
| NestJS | Node.js / TypeScript / NestJS / Prisma | `references/nestjs.md` |
| React | React / TypeScript / Vite / React Router | `references/react.md` |
| Rust | Rust / Cargo / ownership / CLI | `references/rust.md` |

Para tecnologías no cubiertas (Next.js, Flutter, frameworks web de Go, etc.), el agente arma un curriculum basándose en `language-general.md`. Puedes añadir tu propio fichero de referencia (ver "Personalización").

---

## Instalación

Este repositorio contiene los **ficheros fuente**. Hay tres formas de instalar.

### A) Descargar el `.skill` desde GitHub Releases (la más sencilla)

1. Consigue el último `programming-tutor.skill` en la [página de Releases](https://github.com/SimJ/programming-tutor-skill/releases)
2. **Claude Code**: doble clic en el `.skill`, o usa "Install Skill" en la UI
3. **Cowork**: arrastra el `.skill` al chat y pulsa "Save Skill"

### B) Clonar el repositorio directamente en tu carpeta de skills

Ideal si quieres seguir `main` siempre al día.

```bash
# Claude Code
git clone https://github.com/SimJ/programming-tutor-skill.git ~/.claude/skills/programming-tutor

# Para Cowork, clónalo dentro de la carpeta de skills que aparece en ajustes
```

Para actualizar: `cd ~/.claude/skills/programming-tutor && git pull`.

### C) Construir el `.skill` tú mismo

Útil si has hecho un fork y lo modificaste, o si aún no hay Release publicado.

```bash
git clone https://github.com/SimJ/programming-tutor-skill.git
cd programming-tutor-skill
bash scripts/build.sh
# => dist/programming-tutor.skill
```

Luego instálalo como en la opción A.

---

## Cómo usarla

### 1. Actívala

Dispara con cualquier frase que muestre intención de aprender. No hace falta decir "usa esta skill".

- "Quiero aprender Rust desde cero"
- "Ayúdame a ser bueno con Spring Boot"
- "Enséñame React paso a paso"
- "Revisa mi código TypeScript"
- "Soy nuevo programando, ¿por dónde empiezo?"

Para invocarla explícitamente: "con la skill programming-tutor".

### 2. Responde a la entrevista inicial

El agente hace 4 preguntas al inicio (la mayoría como opción múltiple vía `AskUserQuestion`):

- Tecnología objetivo (lenguaje/framework)
- Nivel actual (principiante / con experiencia en otros lenguajes / bases cubiertas / intermedio+)
- Objetivo (trabajo / hobby / certificación o entrevista / curiosidad)
- Ritmo (tiempo al día, fecha objetivo)

También verifica tu entorno (OS, editor, versiones de runtime). Ayuda con:

```bash
bash scripts/check_env.sh rust     # tecnología específica
bash scripts/check_env.sh all      # todo de golpe
```

### 3. Recibe tu plan de aprendizaje

Aparecen dos ficheros en el directorio de trabajo: `learning-plan.md` (capítulos, estados objetivo, herramientas, entregable final) y `progress.md` (seguimiento paso a paso). Lo revisas, pides ajustes y confirmas.

### 4. Entra en el bucle paso a paso

Cada paso tiene esta estructura:

```
## Step N: <título>
### Por qué importa
### Idea central
### Ejemplo mínimo
### Tu tarea
- [ ] haz esto
- [ ] y luego esto
```

Después **el agente se detiene y espera**. Tú escribes el código en VS Code.

### 5. Avisa con palabras clave

| Tú dices | Qué pasa |
| --- | --- |
| "listo" / "hecho" | Se pasa al siguiente paso; se actualiza `progress.md`; se presenta el siguiente |
| "revisa" / "míralo" | Revisión de código: bugs → diseño → estilo |
| "pista" / "atascado" | Pistas graduales: pregunta → concepto relacionado → fragmento parcial → respuesta final (último recurso) |
| "siguiente" | Avanzar |
| "pausa" | Resumen del estado actual, fácil de retomar |
| "saltar" / "más difícil" | Ajuste de dificultad |
| "cambiar de tecnología" | Reinicio con nueva entrevista |

### 6. Formato de revisión de código

```
👍 Puntos fuertes        (1–3 cosas concretas)
🚨 Hay que corregir (bugs)  (máxima prioridad)
⚠️ Conviene mejorar (diseño) (máx. 2)
💡 Estilo / futuro       (opcional)
Siguiente acción         (seguir / arreglar y reenviar)
```

La profundidad del feedback se ajusta a tu nivel — principiantes no reciben críticas de estilo superficiales; avanzados reciben discusión de trade-offs de diseño.

---

## Estructura del directorio

```
programming-tutor/
├── SKILL.md                          # Definición del comportamiento del agente
├── README.md                         # Japonés (por defecto)
├── README.en.md                      # Inglés
├── README.zh.md                      # Chino
├── README.es.md                      # Español (este fichero)
├── README.fr.md                      # Francés
├── LICENSE                           # MIT
├── references/                       # Materiales cargados bajo demanda
│   ├── pedagogy.md
│   ├── onboarding.md
│   ├── code_review.md
│   ├── language-general.md
│   ├── dotnet.md
│   ├── spring-boot.md
│   ├── nestjs.md
│   ├── react.md
│   └── rust.md
├── assets/                           # Plantillas que el agente clona
│   ├── learning-plan-template.md
│   ├── progress-tracker-template.md
│   └── exercise-template.md
└── scripts/
    └── check_env.sh
```

"Bajo demanda" significa que solo se carga la referencia de la tecnología que estás aprendiendo. El contexto del agente se mantiene ligero.

---

## Soporte multilingüe

La skill admite 5 idiomas para el aprendiz: **日本語 / English / 中文 (简体) / Español / Français**.

- El agente detecta tu idioma a partir del primer mensaje
- Si hay duda, pregunta una vez con opción múltiple
- Puedes cambiar en cualquier momento: "from now on in English", "请用中文", "en español por favor", "passons au français", "日本語に戻して"
- Código, nombres de fichero, comandos y librerías se mantienen siempre en inglés

---

## Personalización

### Añadir una tecnología

Para un framework no cubierto (p. ej. Next.js):

1. Crea `references/nextjs.md` inspirándote en `react.md` o `nestjs.md`
2. Incluye: prerequisitos, curriculum capítulo a capítulo con estados objetivo, errores comunes, focos de revisión de código, entregables recomendados
3. Añádelo a la lista de referencias en la sección Planning de `SKILL.md`

### Ajustar el estilo de enseñanza

- Tamaño de los pasos → edita `references/pedagogy.md` "step-size checklist"
- Dureza de la revisión → edita `references/code_review.md` "depth by level"
- Tono/idioma → edita `SKILL.md` "Language handling"

### Dónde van los ficheros de progreso

Por defecto `learning-plan.md` y `progress.md` se crean en la raíz del directorio de trabajo. Puedes decir "ponlos en ./docs/" y el agente obedecerá.

---

## FAQ

**P: Quiero ir más rápido, tanta confirmación me ralentiza.**
R: Di "modo automático" o "avanza hasta el capítulo 3". La skill lo respeta, pero avisa que la retención baja.

**P: El agente no me da la respuesta directa.**
R: Es deliberado. Tras 2–3 intercambios de pistas, te muestra la solución completa con explicación. Si la necesitas ya: "dame la respuesta".

**P: Quiero cambiar de tecnología.**
R: Di "cambiar a React" — se vuelve a ejecutar la entrevista para el nuevo tema. Tu `progress.md` anterior permanece.

**P: ¿Puedo usarla a lo largo de varias sesiones (semanas/meses)?**
R: Sí. Empieza cada sesión con "continuemos donde lo dejamos"; el agente lee `progress.md` y retoma. Mantén el mismo directorio de trabajo.

**P: Tengo que entregar código en el trabajo.**
R: No uses esta skill; usa Claude / Claude Code normal. Esta deliberadamente va más lenta para maximizar aprendizaje.

**P: Mi fichero es enorme, ¿puedes revisarlo?**
R: Con más de ~500 líneas, el agente pregunta "¿en qué parte me concentro?". En el aprendizaje normal no se generan ficheros de ese tamaño.

**P: No se activó.**
R: Edita el `description` de `SKILL.md` para incluir tus frases habituales. O invócala explícitamente: "con programming-tutor".

---

## Versiones

- v1: abril de 2026
- Licencia: MIT (puedes forkear y modificar libremente)
- Feedback: abre un issue en el repositorio, o dile a Claude: "actualiza `references/pedagogy.md` en..."

---

## Créditos

Construido siguiendo el patrón `skill-creator` de Anthropic.
La estructura (`SKILL.md` + `references/` + `assets/` + `scripts/`) usa progressive disclosure: solo se carga el contexto relevante en cada sesión.
