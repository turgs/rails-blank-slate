/* eslint no-console:0 */

/*
 * STIMULUS
 */
import { Application } from 'stimulus'
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))



/*
 * TAILWIND
 */
import '../css/application.css';
