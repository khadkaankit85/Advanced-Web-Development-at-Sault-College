import "./App.css";
import HeroSection from "./components/Herosection.jsx";
import Body from "./components/Body.jsx";
import Navbar from "./components/Navbar.jsx";
import Footer from "./components/Footer.jsx";

const App = () => {
  return (
    <div>
      <Navbar />
      <HeroSection />
      <Body />
      <Footer />
    </div>
  );
};

export default App;
