[ncuapi]: https://github.com/NeiagariCinematicUniverse/NcuApi


# NcuWiki
This is the repository that will host all the code used to make the NCU's wiki.

## Functioning
Alright, since it might not be all that clear for everyone, I'm gonna explain how
this piece of software is meant to work initially.

First off, know that there are two parts: one for the client side exclusively (this
one) and one for the server side exclusively (the 
[NcuApi][ncuapi]). As a natural effect of this approach,
the API is able to work on its own, whereas this part is not, since it relies on the
data retreivable from the API.

Don't get me wrong though. The app will run, but the pages won't display anything
interesting because the source of data simply isn't there.

Next, this is about Vue.js functioning: there are an `index.html` (in the `public`
subdirectory) file, an `App.vue`, a `main.js` (both in the `src` subdirectory)
a `vue.config.js` and two environment files (at the root). I'm gonna detail these
here a little bit.

### The index (`index.html`)
This file is located at the path `/public/index.html`. It basically contains the
head of the html document composing the app. This is probably the first thing you'll
change if you want to make your own wiki, because this is where the name of the tab
and its icon are defined.

I'd advice you not to touch the rest, but of course you could for instance add fonts
and other stuff.

### The Vue App and main files (`App.vue` & `main.js`)
Located at `/src/main.js` and `/src/App.vue`, these files act the same way a `Main`
would in other programming languages. It is where it all starts and where it all
ends. If you want to register new components, it's in the `main.js` that you've got
to do it. If you want to add pages, it's in the `App.vue` that it's gonna happen ;
simply by registering a new comopnent and telling Vue when to display it thanks to
the `v-if` tag attribute.

If you need more details on that, I recommend you go and read the 
[Vue.js documentation](https://vuejs.org/guide/introduction.html), which is fairly
clear and complete (naturally, you'd tell me).

### The Vue config script (`vue.config.js`)
Normally, you shouldn't have too much to do here. Generally, it's even done
automatically by the extensions (called modules) you may want to add to the wiki.

For instance, in the standard NcuWiki configuration, it defines Vuetify, which is the
framework used by the wiki for displaying the interface. Of course, you could want
to use another one (Quasar, Tailwind...), which would require their own definitions.

This is generally documented by the framework itself so, according to your desires,
I shall encourage you to go and check it to know a bit more on that.

### The environment files (`.env` & `.env.production`)
As their names indicates, one is for production environment, while the other isn't.
It's in these files that you may define variables to pass through to the whole app
(referenced as `process.env.VARIABLE_NAME`). Vue choses automatically which one to
use, so you don't have to think about it too hard.

> **Note:**  
> *It is still pretty important that you make sure the two files contains the SAME
> variables, even though their values might be different.*

## Usage
As it is open source (see [licence terms](#licence) below), you are allowed to use
this repo's code to build the website of your dreams... if Vue.js and markdown are
the technologies of your dreams, of course.

Anyway, you'll find in this section a guide about how to get started and start for
the first time the so called "NcuWiki".

### Getting the code
To get the code, you could of course clone this repository, but I'm sorry to tell
you that I'm mostly not quite likely to accept your changes (I'll review them of
course, but those changes shall have something to do with this wiki, not yours).

If your wish is to create your own wiki, using the code that's already done here, I
would advice you to fork it, so that it becomes yours! This way you'll get a great
playground, that is yours only!

Once you forked it, you can clone YOUR repository (not this one) and make the changes
you want, which won't be reverberated to this repository. And when you finally have
the code one your computer, then you can start working.

### Starting the program
So, you have now made your first changes to the app and you want to see them live to
make sure you haven't messed up too bad.

Simple, you just have to run the following commands:
```
npm install
```
This will install the modules which are (of course) not kept within the github repo.
By the way, it may sometimes feel boring to have trouble because of them, so you
might think it is a good idea to share them with everyone by putting them in your
github repository.

Well, even though this is possible by editing the `.gitignore` file at the root, I
strongly recommend you not to do that. EVER. It's gonna mess up everything so hard
that in the end, you might even find it struggling to push your changes or pull the
repository from somewhere else. So, yeah, don't do that. Really.

Anyway, back to our program ; the next command is about how to make it run in a local
server that you can visualise on yout machine:
```
npm run serve
```
Once the app is running, you can go and check it [here](http://localhost:8080), but
you might not be seeing much, as the API working along side it is probably not
lanched though.

> **Note:**  
> *If you are slightly used to Vue, you might have notices that I'm using the `serve`
> name instead of the `dev`. Those are technically the same, however the `dev` alias
> is only defined by default on Vue 3 web apps, while this one is a Vue 2, in order
> to remain compatible with Vuetify framework, which hadn't released a version for
> Vue 3 at the time I started working on this wiki.*
>
> *This could be a change in the future, but it is not a priority at all for the time
> being.*

For more details on the API, go check the 
[Ruby API made to go along this wiki][ncuapi].

### Making it yours!
As an effort to make this repository reusable for anyone that might want to do a
similar kind of app, I am going to ensure all you have to change stays in the same
place: the [environment files](#the-environment-files-env--envproduction).

It isn't yet the case, but it is going to be in a soon release, so please be a little
more patient, I think it's worth the wait. (Laybe I'm too full of myself...)

> **Note:**  
> *While I am saying this, you shall keep in mind that there is ONE thing that can't
> be changed dynamically, that is the [`index.html`](#the-index-indexhtml) file.*
> 
> *In the end, you will have to edit three files :*
> - *`/public/index.html`*
> - *`/.env`*
> - *`/.env.production`*

## Licence
This repository is licenced under the MIT licence terms. That means that you are
allowed to do whatever you want with the code here, as long as you cite its
authors in a visible place (in the info pop-up for instance 👍️).
