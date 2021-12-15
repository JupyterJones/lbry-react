import logo from './LBRY.png';
import $ from "jquery";
import './App.css';
import LogRocket from 'logrocket';
LogRocket.init('zt2p4u/lbry-react');

$(function(){
  var x = 0;
  setInterval(function(){
      x-=2;
      $('header').css('background-position', x + 'px 0');
  }, 300);
})

function App() {
  return (
    <div className="App">
      <header className="App-header">
        
        <img src={logo} className="App-logo" alt="logo" />
        <a
          className="App-link"
          href="https://doodad.dev/pattern-generator/"
          target="_blank"
          rel="noopener noreferrer"
        >
          Pattern Generator
        </a>

    <form>
       <label>
          Name:
          <input type="text" name="name" />
       </label>
          <input type="submit" value="Submit" />
   </form>

        
      </header>
    </div>
  );
}

export default App;
